# == Schema Information
#
# Table name: credits
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  amount     :integer
#  note       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Credit < ActiveRecord::Base
end
