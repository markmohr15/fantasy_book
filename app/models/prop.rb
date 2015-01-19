# == Schema Information
#
# Table name: props
#
#  id         :integer          not null, primary key
#  sport_id   :integer
#  player1_id :integer
#  player2_id :integer
#  player3_id :integer
#  player4_id :integer
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Prop < ActiveRecord::Base

  belongs_to :sport
  belongs_to :player1, class_name: "Player"
  belongs_to :player2, class_name: "Player"
  belongs_to :player3, class_name: "Player"
  belongs_to :player4, class_name: "Player"

  validates :sport_id, presence: true
  validates :player1_id, presence: true
  validates :player2_id, presence: true
  validates :player3_id, presence: true
  validates :player4_id, presence: true
  validates :time, presence: true

end
