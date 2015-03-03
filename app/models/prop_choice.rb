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
#  available  :integer          default("0")
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

  store_cents :available

  attr_accessor :player1, :player2, :player3, :player4, :player5

  def name
    names = []
    self.choice.each do |choice|
      names << Player.find_by(id: choice).name
    end
    names.join(", ")
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

  def player3=(value)
    return if value.blank?
    player = Player.find_by id: value
    if player.nil?
      player = Player.find_by name: value
    end
    self.choice ||= []
    self.choice[2] = player.id
  end

  def player4=(value)
    return if value.blank?
    player = Player.find_by id: value
    if player.nil?
      player = Player.find_by name: value
    end
    self.choice ||= []
    self.choice[3] = player.id
  end

  def player5=(value)
    return if value.blank?
    player = Player.find_by id: value
    if player.nil?
      player = Player.find_by name: value
    end
    self.choice ||= []
    self.choice[4] = player.id
  end

  def player1
    return if choice.nil?
    return if self.choice[0].nil?
    Player.find_by(id: self.choice[0]).name
  end

  def player2
    return if choice.nil?
    return if self.choice[1].nil?
    Player.find_by(id: self.choice[1]).name
  end

  def player3
    return if choice.nil?
    return if self.choice[2].nil?
    Player.find_by(id: self.choice[2]).name
  end

  def player4
    return if choice.nil?
    return if self.choice[3].nil?
    Player.find_by(id: self.choice[3]).name
  end

  def player5
    return if choice.nil?
    return if choice[4].nil?
    Player.find_by(id: self.choice[4]).name
  end

  def display_line
    if self == self.prop.prop_choices.first
      self.prop.opt1_spread_line.to_s + " " + self.odds_juice.to_s
    else
      self.prop.opt2_spread_line.to_s + " " + self.odds_juice.to_s
    end
  end

  def choice_win
    wagers = Wager.where(prop_choice_id: self.id)
    counter = 0
    wagers.each do |wager|
      counter += wager.win
    end
    counter / 100.0
  end

  def choice_risk
    wagers = Wager.where(prop_choice_id: self.id)
    counter = 0
    wagers.each do |wager|
      counter += wager.risk
    end
    counter / 100.0
  end
end
