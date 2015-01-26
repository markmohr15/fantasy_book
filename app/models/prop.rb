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
  enum state: [ :Offline, :Open, :Closed, :Graded, :No_Action, :Regrade ]

  after_commit :check_state

  def check_state
    if self.away_score != nil && self.home_score != nil && self.state == "Closed"
      self.grade_prop!
    elsif self.state == "Regrade"
      self.ungrade_wagers
      self.grade_wagers
      self.state = "Graded"
      self.save
    elsif self.state == "No_Action"
      self.ungrade_wagers
      self.void_prop!
    end
  end

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

    state :Graded, after_commit: :grade_wagers

    event :void_prop do
      transitions to: :No_Action
    end

    state :No_Action, after_commit: :cancel_wagers

    event :regrade_prop do
      transitions from: :Graded, to: :Regraded
    end

    state :Regrade
  end

  def grade_wagers
    wagers = Wager.where(prop_id: self.id)
    wagers.map do |wager|
      if wager.pick = "away"
        if self.away_score + wager.spread > self.home_score
          wager.win_wager!
        elsif self.away_score + wager.spread < self.home_score
          wager.lose_wager!
        else
          wager.void_wager!
        end
      else
        if self.home_score + wager.spread > self.away_score
          wager.win_wager!
        elsif self.home_score + wager.spread < self.away_score
          wager.lose_wager!
        else
          wager.void_wager!
        end
      end
    end
  end

  def ungrade_wagers
    wagers = Wager.where(prop_id: self.id)
    wagers.map do |wager|
      if wager.state == "Won"
        wager.user.balance -= (wager.risk + wager.win)
        wager.user.save
        wager.state = "Pending"
        wager.save
      elsif wager.state == "No_Action"
        wager.user.balance -= wager.risk
        wager.user.save
        wager.state = "Pending"
        wager.save
      elsif wager.state == "Lost"
        wager.state = "Pending"
        wager.save
      end
    end
  end

  def cancel_wagers
    wagers = Wager.where(prop_id: self.id)
    wagers.map do |wager|
      wager.void_wager!
    end
  end

end
