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
#  state       :integer          default("0")
#  away_score  :float(24)
#  home_score  :float(24)
#
# Indexes
#
#  index_props_on_player1_id  (player1_id)
#  index_props_on_player2_id  (player2_id)
#  index_props_on_player3_id  (player3_id)
#  index_props_on_player4_id  (player4_id)
#  index_props_on_sport_id    (sport_id)
#

class Prop < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :sport
  belongs_to :player1, class_name: "Player"
  belongs_to :player2, class_name: "Player"
  belongs_to :player3, class_name: "Player"
  belongs_to :player4, class_name: "Player"
  has_many :wagers

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

    event :allow_wagering do
      transitions from: :Offline, to: :Open
    end

    state :Open

    event :close_prop do
      transitions from: :Open, to: :Closed
    end

    event :pause_prop do
      transitions from: :Open, to: :Offline
    end

    state :Closed

    event :grade_prop do
      transitions from: :Closed, to: :Graded
    end

    state :Graded, after_enter: :grade_wagers

    event :void_prop do
      transitions to: :No_Action
    end

    state :No_Action, after_enter: :stuff
  end

  def grade_wagers
    wagers = Wager.where(prop_id: id)
    wagers.map do |wager|
      if wager.pick = "away"
        if away_score + wager.spread > home_score
          wager.win_wager!
        elsif away_score + wager.spread < home_score
          wager.lose_wager!
        else
          wager.void_wager!
        end
      else
        if home_score + wager.spread > away_score
          wager.win_wager!
        elsif home_score + wager.spread < away_score
          wager.lose_wager!
        else
          wager.void_wager!
        end
      end
    end
  end

end
