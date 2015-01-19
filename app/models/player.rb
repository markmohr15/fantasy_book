# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  sport_id   :integer
#  name       :string(255)
#  team       :string(255)
#  position   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ActiveRecord::Base

  belongs_to :sport
  has_many :players_as_player1, class_name: "Prop", foreign_key: "player1_id"
  has_many :players_as_player2, class_name: "Prop", foreign_key: "player2_id"
  has_many :players_as_player3, class_name: "Prop", foreign_key: "player3_id"
  has_many :players_as_player4, class_name: "Prop", foreign_key: "player4_id"

  validates :name, presence: true
  validates :sport_id, presence: true


end
