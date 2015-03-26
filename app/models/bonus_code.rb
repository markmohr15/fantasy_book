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
#  maximum    :integer          default("1000000")
#  enabled    :boolean          default("1")
#  one_time   :boolean          default("1")
#

class BonusCode < ActiveRecord::Base
  include StorageConversions

  has_many :bonuses

  validates :code, presence: true
  validates :code, uniqueness: true
  validates :percentage, presence: true
  validates :rollover, presence: true
  validates :maximum, presence: true

  store_cents :maximum
end
