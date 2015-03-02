# == Schema Information
#
# Table name: wagers
#
#  id             :integer          not null, primary key
#  prop_id        :integer
#  user_id        :integer
#  state          :integer          default("0")
#  risk           :integer
#  win            :integer
#  prop_choice_id :integer
#  odds           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  spread         :float(24)
#  total          :float(24)
#
# Indexes
#
#  index_wagers_on_prop_id  (prop_id)
#  index_wagers_on_user_id  (user_id)
#

class Wager < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :user
  belongs_to :prop, touch: true
  belongs_to :prop_choice
  validates :prop_id, presence: true
  validates :user_id, presence: true
  validates :risk, presence: true
  validates :odds, presence: true
  validates :prop_choice_id, presence: true
  validate :open?, :odds?, :spread?

  display_line :spread
  display_juice :odds
  store_cents :risk, :win

  before_validation :get_win, on: [:create, :update]

  enum state: [ :Pending, :Won, :Lost, :No_Action ]
  after_create :deduct_risk

  aasm column: :state do
    state :Pending, initial: true

    event :win_wager do
      transitions from: :Pending, to: :Won
    end

    state :Won, after_commit: :pay_win

    event :lose_wager do
      transitions from: :Pending, to: :Lost
    end

    state :Lost

    event :void_wager do
      transitions to: :No_Action
    end

    state :No_Action, after_commit: :return_risk
  end

  def result
    if self.state == "Won"
      self.win_dollars
    elsif self.state == "Lost"
      self.risk_dollars * -1
    else
      0
    end
  end

  def get_win
    if self.odds > 0
      self.win = (risk * self.odds / 100.0).round
    else
      self.win = (risk * -100.0 / self.odds).round
    end
  end

  def deduct_risk
    self.user.balance -= self.risk
    self.user.save
  end

  def pay_win
    self.user.balance += (self.risk + self.win)
    self.user.save
  end

  def return_risk
    self.user.balance += self.risk
    self.user.save
  end

  def ungrade_wager
    if self.state == "Won"
      self.user.balance -= (self.risk + self.win)
      self.user.save
    elsif self.state == "No_Action"
      self.user.balance -= self.risk
      self.user.save
    end
    self.state = "Pending"
    self.save
  end

  def open?
    if self.prop.state != "Open"
      errors[:base] << "Prop is not open for wagering."
    end
  end

  def odds?
    pc = self.prop_choice
    if self.odds != pc.odds
      errors[:base] << "Prop odds have changed."
    end
  end

  def spread?
    if self.prop.variety == "Over/Under" && self.prop.over_under != self.total
      errors[:base] << "Prop total has changed."
    elsif self.prop.variety == "Fantasy" || self.prop.variety == "2P Fantasy"
      if self.prop_choice == self.prop.prop_choices.first && self.spread != self.prop.opt1_spread
        errors[:base] << "Prop odds have changed."
      elsif self.prop_choice == self.prop.prop_choices.last && self.spread != self.prop.opt2_spread
        errors[:base] << "Prop odds have changed."
      end
    end
  end

  def self.pending_wagers(user)
    wagers = Wager.where(user_id: user.id, state: "Pending")
    counter = 0
    wagers.map do |wager|
      counter += wager.risk_dollars
    end
    counter
  end
end
