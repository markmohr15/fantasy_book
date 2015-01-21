# == Schema Information
#
# Table name: props
#
#  id          :integer          not null, primary key
#  sport_id    :integer
#  player1_id  :integer
#  player2_id  :integer
#  player3_id  :integer
#  player4_id  :integer
#  time        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  home_spread :float(24)
#  home_vig    :integer
#  away_vig    :integer
#  winner      :integer
#  state       :integer          default("0")
#

class Prop < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :sport
  belongs_to :player1, class_name: "Player"
  belongs_to :player2, class_name: "Player"
  belongs_to :player3, class_name: "Player"
  belongs_to :player4, class_name: "Player"

  validates :sport_id, presence: true
  validates :player1_id, presence: true
  validates :player2_id, presence: true
  validates :player3_id, presence: true
  validates :player4_id, presence: true
  validates :time, presence: true

  display_juice :home_vig, :away_vig
  display_line :home_spread

  enum winner: [ :away, :home ]

  enum state: [ :Offline, :Open, :Closed, :Graded, :No_Action ]

  aasm column: :state do
    state :Offline, initial: true

    event :allow_wager do
      transitions from: :Offline, to: :Open
    end

    state :Open

    event :close_wager do
      transitions from: :Open, to: :Closed
    end

    event :pause_wager do
      transitions from: :Open, to: :Offline
    end

    state :Closed

    event :grade_wager do
      transitions from: :Closed, to: :Graded
    end

    state :Graded

    event :void_wager do
      transitions to: :No_Action
    end

    state :No_Action
  end
end
