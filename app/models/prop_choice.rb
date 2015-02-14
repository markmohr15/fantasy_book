# == Schema Information
#
# Table name: prop_choices
#
#  id         :integer          not null, primary key
#  prop_id    :integer
#  choice     :text(65535)
#  odds       :integer
#  score      :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  winner     :boolean          default("0")
#
# Indexes
#
#  index_prop_choices_on_prop_id  (prop_id)
#

class PropChoice < ActiveRecord::Base
  include StorageConversions

  has_many :wagers
  belongs_to :prop
  serialize :choice
  display_juice :odds
  display_line :spread

  validates :choice, presence: true
  validates :odds, presence: true

  attr_accessor :player1, :player2, :choice_raw

  def choice_raw
    self.choice.join("\n") unless self.choice.nil?
  end

  def choice_raw=(values)
    self.choice = []
    self.choice = values.split("\n")
  end

  def name
    if self.prop.variety == "Other" || self.prop.variety == "Over/Under"
      self.choice_raw
    elsif self.prop.variety == "Fantasy"
      self.player1
    else
      self.player1 + " & " + self.player2
    end
  end

  def player1=(value)
    return if value.blank?
    player = Player.find_by id: value
    if player.nil?
      player = Player.find_by name: value
    end
    self.choice ||= []
    self.choice[0] = player.id
  end

  def player2=(value)
    return if value.blank?
    player = Player.find_by id: value
    if player.nil?
      player = Player.find_by name: value
    end
    self.choice ||= []
    self.choice[1] = player.id
  end

  def player1
    return if choice.nil?
    Player.find_by(id: self.choice[0]).name
  end

  def player2
    return if choice.nil?
    Player.find_by(id: self.choice[1]).name
  end

  def display
    if self.prop.variety == "Other"
      self.choice_raw
    elsif self.prop.variety == "Over/Under"
      self.choice_raw + " " + self.prop.over_under.to_s
    elsif self.prop.variety == "Fantasy"
      if self == self.prop.prop_choices.first
        self.player1 + " " + self.prop.opt1_spread_line.to_s
      else
        self.player1 + " " + self.prop.opt1_spread_line.to_s
      end
    else
      self.player1 + " & " + self.player2 + " " + self.prop.opt1_spread_line
    end
  end
end
