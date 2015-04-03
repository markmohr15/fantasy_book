# == Schema Information
#
# Table name: bonus_codes
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  percentage :integer
#  rollover   :integer
#  note       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  maximum    :integer          default("20000")
#  enabled    :boolean          default("1")
#  one_time   :boolean          default("1")
#  length     :integer
#

class BonusCode < ActiveRecord::Base
  include StorageConversions

  has_many :bonuses

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :percentage, presence: true
  validates :rollover, presence: true
  validates :maximum, presence: true
  validates :length, presence: true

  store_cents :maximum

  def self.pending_by_code(code)
    bonuses = Bonus.where(bonus_code_id: code.id, state:0)
    counter = 0
    bonuses.each do |bonus|
      counter += bonus.pending_dollars
    end
    counter
  end

  def self.total_by_code(code)
    bonuses = Bonus.where(bonus_code_id: code.id)
    counter = 0
    bonuses.each do |bonus|
      counter += bonus.amount_dollars
    end
    counter
  end
end
