# == Schema Information
#
# Table name: prop_choices
#
#  id         :integer          not null, primary key
#  prop_id    :integer
#  choice     :text(65535)
#  odds       :integer
#  spread     :float(24)
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

  validates :prop_id, presence: true
  validates :choice, presence: true
  validates :odds, presence: true
  validates :spread, presence: true
end
