# == Schema Information
#
# Table name: bonus
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :integer
#  pending    :integer
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bonu < ActiveRecord::Base
end
