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
  validate :open?, :odds?, :spread?, :available?, on: :create, if: :player?

  display_line :spread
  display_juice :odds
  store_cents :risk, :win

  before_validation :get_win, on: [:create, :update], if: :player?

  enum state: [ :Pending, :Won, :Lost, :Push, :No_Action ]
  after_create :deduct_risk
  after_create :contra, if: :player?
  after_create :deduct_available, if: :player?

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

    event :push_wager do
      transitions from: :Pending, to: :Push
    end

    state :Push, after_commit: :return_risk

    event :void_wager do
      transitions to: :No_Action
    end

    state :No_Action, after_commit: :return_risk
  end

  def player?
    self.user.role == "player"
  end

  def contra
    if self.prop_choice == prop.prop_choices.first
      contra_prop_choice = prop.prop_choices.last
    else
      contra_prop_choice = prop.prop_choices.first
    end
    Wager.create(prop_id: self.prop.id, user_id: self.prop.user_id, risk: self.win, win: self.risk,
      prop_choice_id: contra_prop_choice.id, odds: self.odds * -1, spread: self.spread * -1 )
  end

  def deduct_available
    self.prop_choice.available -= self.risk
    self.prop_choice.save
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
    elsif self.state == "No_Action" || self.state == "Push"
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
    if self.odds != self.prop_choice.odds
      errors[:base] << "Prop odds have changed."
    end
  end

  def spread?
    if self.prop_choice == self.prop.prop_choices.first && self.spread != self.prop.opt1_spread
      errors[:base] << "Prop odds have changed."
    elsif self.prop_choice == self.prop.prop_choices.last && self.spread != self.prop.opt2_spread
      errors[:base] << "Prop odds have changed."
    end
  end

  def available?
    if self.prop_choice.available == 0
      errors[:base] << "Prop is not currently available."
    elsif self.risk > self.prop_choice.available
      errors[:base] << "Risk amount is greater than available amount."
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

  def self.pending_vip_wagers
    wagers = Wager.joins(:user).where('users.role' => 3, 'state' => 0)
    counter = 0
    wagers.map do |wager|
      counter += wager.risk_dollars
    end
    counter
  end

  def self.vip_results(start_time, finish_time)
    wagers = Wager.joins(:user).joins(:prop).where('users.role' => 3, 'state' => 1..2,
     'props.time' => start_time..finish_time )
    counter = 0
    wagers.map do |wager|
      counter += wager.result
    end
    counter
  end

  def self.player_results(user, start_time, finish_time)
    wagers = Wager.joins(:prop).where('user_id' => user.id, 'state' => 1..2, 'props.time' => start_time..finish_time)
    counter = 0
    wagers.map do |wager|
      counter += wager.result
    end
    counter
  end

end
