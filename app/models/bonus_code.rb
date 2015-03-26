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
#

class BonusCode < ActiveRecord::Base
  include StorageConversions

  has_many :bonuses

  store_cents :maximum
end
