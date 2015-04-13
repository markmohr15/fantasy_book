# == Schema Information
#
# Table name: bonuses
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  amount        :integer
#  pending       :integer
#  rollover      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state         :integer
#  released      :integer          default("0")
#  bonus_code_id :integer
#  exp_date      :date
#
# Indexes
#
#  index_bonuses_on_bonus_code_id  (bonus_code_id)
#  index_bonuses_on_user_id        (user_id)
#

class Bonus < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :user
  belongs_to :bonus_code
  validates :user_id, presence: true
  validates :amount, presence: true
  validate :available?, on: :create

  store_cents :amount, :pending, :released

  enum state: [ :Pending, :Complete, :Expired ]

  before_validation :set_amounts, on: :create
  before_save :release, on: :edit

  def available?
    unless self.bonus_code.nil?
      if self.bonus_code.enabled == false
        errors[:base] << "Bonus Code not available"
      end
      if Bonus.where(user_id: self.user.id, bonus_code_id: self.bonus_code_id).exists? && self.bonus_code.one_time == true
        errors[:base] << "Bonus Code already redeemed"
      end
    end
  end

  def set_amounts
    unless self.bonus_code.nil?
      self.rollover = self.bonus_code.rollover
      self.exp_date = Date.today + self.bonus_code.length.days
      if self.amount > self.bonus_code.maximum
        self.amount = self.bonus_code.maximum
      end
    end
    self.pending = self.amount
  end

  def description
    if self.bonus_code.nil?
      "Other"
    else
      self.bonus_code.code
    end
  end

  def earned
    self.amount_dollars - self.pending_dollars - self.released_dollars
  end

  def process_bonus(wager_amount)
    self.pending -= wager_amount / self.rollover
    if self.pending <= 0
      extra = self.pending * self.rollover * -1
      self.pending = 0
      self.complete_bonus!
      nextBonus = Bonus.find_by(user_id: self.user_id, state: "Pending")
      unless nextBonus.nil?
        nextBonus.process_bonus(extra)
      end
    end
    self.save
  end

  def release
    earned = self.amount_dollars - self.pending_dollars
    not_released = earned - self.released_dollars
    not_released = not_released - not_released % 10
    self.user.balance += not_released * 100
    self.released += not_released * 100
    if self.pending == 0 && self.released != self.amount
      self.user.balance_dollars += self.amount_dollars - self.released_dollars
      self.released = self.amount
    end
    self.user.save
  end

  def self.pending_bonuses(user)
    bonuses = Bonus.where(user_id: user.id, state: "Pending")
    counter = 0
    bonuses.map do |bonus|
      counter += bonus.pending_dollars
    end
    counter
  end

  def self.earned_bonuses(user)
    bonuses = Bonus.where(user_id: user.id, state: "Pending")
    counter = 0
    bonuses.map do |bonus|
      counter += bonus.earned
    end
    counter
  end

  def self.total_pending_bonuses
    bonuses = Bonus.where(state:0)
    counter = 0
    bonuses.each do |bonus|
      counter += bonus.pending_dollars
    end
    counter
  end

  aasm column: :state do
    state :Pending, initial: true

    event :complete_bonus do
      transitions from: :Pending, to: :Complete
    end

    state :Complete

    event :expire_bonus do
      transitions from: :Pending, to: :Expired
    end

    state :Expired

  end
end
