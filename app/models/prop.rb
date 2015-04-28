# == Schema Information
#
# Table name: props
#
#  id             :integer          not null, primary key
#  sport_id       :integer
#  time           :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  state          :integer          default("0")
#  proposition    :text(65535)
#  opt1_spread    :float(24)
#  opt2_spread    :float(24)
#  winner         :integer
#  user_id        :integer
#  delayed_job_id :integer
#  tv             :string(255)      default("")
#
# Indexes
#
#  index_props_on_sport_id  (sport_id)
#  index_props_on_user_id   (user_id)
#

class Prop < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :sport
  belongs_to :user
  has_many :wagers, dependent: :restrict_with_error
  has_many :prop_choices
  accepts_nested_attributes_for :prop_choices, allow_destroy: true

  validates :sport_id, presence: true
  validates :time, presence: true

  just_define_datetime_picker :time
  display_line :opt1_spread
  display_line :opt2_spread

  enum state: [ :Offline, :Open, :Closed, :Graded, :Regrade ]
  enum winner: [ :Team1, :Team2, :Push, :NoAction]

  after_initialize :set_time, :set_opt1_spread
  before_save :check_state
  before_validation :get_opt2_spread
  after_save :close_wagering, if: Proc.new {|a| a.time_changed?}
  after_save :get_dj_id, if: Proc.new {|a| a.time_changed?}
  #after_touch :auto_move_odds
  attr_accessor :ampm_time

  def set_time
    self.time ||= Time.now
  end

  def set_opt1_spread
    self.opt1_spread ||= 0
  end

  def ampm_time
    self.time.strftime("%I:%M %P")
  end

  def self.search(search_string)
    players = Player.where('name LIKE ? or team LIKE ?', "%#{search_string}%", "%#{search_string}%")
    prop_collection = []
    props = []
    all_prop_choices = PropChoice.joins(:prop).where('props.state' => 1)
    players.each do |player|
      all_prop_choices.each do |pc|
        if pc.choice.include? player.id
          prop_collection << pc.prop.id
        end
      end
    end
    #choice_collection.flatten.each do |choice|
     # props << choice.prop_id if choice.prop.state == "Open"
    #end
    self.where("id in (?)", prop_collection)
  end

  def check_state
    if self.state == "Closed" && has_winner?
      self.grade_prop!
      wagers = Wager.where(prop_id: self.id)
      wagers.each do |wager|
        if wager.user.email_notif?
          MailgunMailer.contest_graded(wager).deliver_later
        end
        #if wager.user.sms_notif?
         # Text.contest_graded(wager)
        #end
      end
    elsif self.state == "Regrade"
      self.ungrade_wagers
      self.state = "Closed"
      self.grade_prop!
      wagers = Wager.where(prop_id: self.id)
      wagers.each do |wager|
        if wager.user.email_notif?
          MailgunMailer.contest_graded(wager).deliver_later
        end
        #if wager.user.sms_notif?
         # Text.contest_graded(wager)
        #end
      end
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
    (choice_array[place]).to_s + " " + ((win - risk_counter).round(2)).to_s
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

  def get_dj_id
    if self.delayed_job_id
      if Delayed::Job.where(id: self.delayed_job_id).exists?
        Delayed::Job.find(self.delayed_job_id).destroy
      end
    end
    self.delayed_job_id = Delayed::Job.where(queue: "CloseWagering").last.id
    self.save
  end

  handle_asynchronously :get_dj_id, queue: "Get_DJ_ID", :run_at => Proc.new { 5.seconds.from_now }

  def close_wagering
    if self.state == "Offline" || self.state == "Open"
      self.state = "Closed"
      self.save
    end
    wagers = Wager.where(prop_id: self.id)
    wagers.each do |wager|
      if wager.user.email_notif?
        MailgunMailer.contest_started(wager).deliver_later
      end
      #if wager.user.sms_notif?
       # Text.contest_started(wager)
      #end
    end
  end

  handle_asynchronously :close_wagering, queue: "CloseWagering", :run_at => Proc.new { |i| i.time }

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

    event :regrade_prop do
      transitions from: :Graded, to: :Regrade
    end

    state :Regrade
  end

  def grade_wagers
    wagers = Wager.where(prop_id: self.id)
    choice1 = PropChoice.where(prop_id: self.id).first
    choice2 = PropChoice.where(prop_id: self.id).last
    wagers.map do |wager|
      if wager.prop_choice == choice1
        if wager.prop.winner == "Team1"
          wager.win_wager!
        elsif wager.prop.winner == "Team2"
          wager.lose_wager!
        elsif wager.prop.winner == "Push"
          wager.push_wager!
        else
          wager.void_wager!
        end
      else
        if wager.prop.winner == "Team2"
          wager.win_wager!
        elsif wager.prop.winner == "Team1"
          wager.lose_wager!
        elsif wager.prop.winner == "Push"
          wager.push_wager!
        else
          wager.void_wager!
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

  def display_proposition
    if self.proposition == "Vs."
      self.prop_choices.first.name + " Vs. " + self.prop_choices.last.name
    else
      self.proposition
    end
  end

end
