class Prop < ActiveRecord::Base

  belongs_to :sport
  belongs_to :player1, class_name: "Player"
  belongs_to :player2, class_name: "Player"
  belongs_to :player3, class_name: "Player"
  belongs_to :player4, class_name: "Player"

  validates :sport_id, presence: true

end
