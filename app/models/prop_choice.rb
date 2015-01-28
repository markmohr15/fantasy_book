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
#

class PropChoice < ActiveRecord::Base
  belongs_to :prop
  serialize :choice
  display_juice :odds
end
