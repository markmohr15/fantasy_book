# == Schema Information
#
# Table name: props
#
#  id          :integer          not null, primary key
#  sport_id    :integer
#  time        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  state       :integer          default("0")
#  proposition :text(65535)
#  opt1_spread :float(24)
#  opt2_spread :float(24)
#  winner      :integer
#
# Indexes
#
#  index_props_on_sport_id  (sport_id)
#

class Prop < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :sport
  has_many :wagers
  has_many :prop_choices
  accepts_nested_attributes_for :prop_choices, allow_destroy: true

  validates :sport_id, presence: true
  validates :time, presence: true

  just_define_datetime_picker :time
  display_line :opt1_spread
  display_line :opt2_spread

  enum state: [ :Offline, :Open, :Closed, :Graded, :No_Action, :Regrade ]
  enum winner: [ :Team1, :Team2, :Push, :NoAction]

  after_commit :check_state
  before_validation :get_opt2_spread
  after_touch :auto_move_odds

  def self.search(search_string)
    players = Player.where('name LIKE ? or team LIKE ?', "%#{search_string}%", "%#{search_string}%")
    choice_collection = []
    props = []
    players.each do |player|
      choice_collection << PropChoice.where("choice LIKE '%?%'", player)
    end
    choice_collection.flatten.each do |choice|
      props << choice.prop_id
    end
    self.where("id in (?) OR proposition LIKE ?", props, "%#{search_string}%").where(state: 1)
  end

  def check_state
    if self.state == "Closed" && has_winner?
      self.grade_prop!
    elsif self.state == "Regrade"
      self.ungrade_wagers
      self.grade_wagers
      self.state = "Graded"
      self.save
    elsif self.state == "No_Action"
      self.ungrade_wagers
      self.cancel_wagers
    end
  end

  def get_opt2_spread
    return if self.opt1_spread.blank?
    if self.opt1_spread == 0
      self.opt2_spread = 0
    else
      self.opt2_spread = self.opt1_spread * -1.0
    end
  end

  def exposure
    win_array = []
    risk_array = []
    choice_array = []
    risk_counter = 0
    self.prop_choices.each do |choice|
      win_array << choice.choice_win
      risk_array << choice.choice_risk
      choice_array << choice.id
    end
    win = win_array.max
    place = win_array.index(win_array.max)
    risk_array.delete_at(place)
    risk_array.each do |element|
      risk_counter += element
    end
    (choice_array[place]).to_s + " " + (win - risk_counter).to_s
  end

  def exposure_to_s
    name = PropChoice.find_by(id: self.exposure.split[0]).name
    name + "  (" + self.exposure.split[1] + ")"
  end

  def auto_move_odds
    exposure = self.exposure.split[1].to_i
    id = self.exposure.split[0].to_i
    newLine = exposure / 2500 * -10 + -115
    newLine2 = exposure / 2500 * 10 + -115
    if newLine2 > -100
      newLine2 = newLine2 +=200
    end
    choice = PropChoice.find_by(id: id)
    choice.odds = newLine
    choice.save
    if self.prop_choices.first == choice
      self.prop_choices.last.odds = newLine2
      self.prop_choices.last.save
    else
      self.prop_choices.first.odds = newLine2
      self.prop_choices.first.save
    end
  end

  def has_winner?
    self.winner != nil
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

    state :No_Action

    event :regrade_prop do
      transitions from: :Graded, to: :Regraded
    end

    state :Regrade
  end

  def grade_wagers
    wagers = Wager.where(prop_id: self.id)
    wagers.map do |wager|
      if self.variety == "Other"
        winner = PropChoice.find_by(prop_id: self.id, winner: true).id
        if wager.prop_choice_id == winner
            wager.win_wager!
        else
            wager.lose_wager!
        end
      elsif self.variety == "Over/Under"
        if wager.prop_choice.choice_raw == "Over"
          if self.result > wager.total
            wager.win_wager!
          elsif self.result == wager.total
            wager.void_wager!
          else
            wager.lose_wager!
          end
        else
          if self.result < wager.total
            wager.win_wager!
          elsif self.result == wager.total
            wager.void_wager!
          else
            wager.lose_wager!
          end
        end
      else
        choice1 = PropChoice.where(prop_id: self.id).first
        choice2 = PropChoice.where(prop_id: self.id).last
        if wager.prop_choice == choice1
          if wager.prop_choice.score + wager.spread > choice2.score
            wager.win_wager!
          elsif wager.prop_choice.score + wager.spread == choice2.score
            wager.void_wager!
          else
            wager.lose_wager!
          end
        else
          if wager.prop_choice.score + wager.spread > choice1.score
            wager.win_wager!
          elsif wager.prop_choice.score + wager.spread == choice1.score
            wager.void_wager!
          else
            wager.lose_wager!
          end
        end
      end
    end
  end

  def ungrade_wagers
    wagers = Wager.where(prop_id: self.id)
    wagers.map do |wager|
      wager.ungrade_wager
    end
  end

  def cancel_wagers
    wagers = Wager.where(prop_id: self.id)
    wagers.map do |wager|
      wager.void_wager!
    end
  end

end
