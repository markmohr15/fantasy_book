# == Schema Information
#
# Table name: wagers
#
#  id         :integer          not null, primary key
#  prop_id    :integer
#  user_id    :integer
#  state      :integer          default("0")
#  risk       :integer
#  win        :integer
#  pick       :integer
#  vig        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  spread     :float(24)
#

class Wager < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :user
  belongs_to :prop

  validates :prop_id, presence: true
  validates :user_id, presence: true
  validates :risk, presence: true
  validates :vig, presence: true

  display_line :spread
  display_juice :vig
  store_cents :risk, :win

  before_save :get_win
  before_update

  enum state: [ :Pending, :Won, :Lost, :No_Action ]
  enum pick: [ :away, :home ]

  aasm column: :state do
    state :Pending, initial: true

    event :win_wager do
      transitions from: :Pending, to: :Won
    end

    state :Won

    event :lose_wager do
      transitions from: :Pending, to: :Lost
    end

    state :Lost

    event :void_wager do
      transitions to: :No_Action
    end

    state :No_Action
  end

  def get_win
    if vig > 0
      self.win = (risk * vig / 100.0).round
    else
      self.win = (risk * -100.0 / vig).round
    end
  end

end
