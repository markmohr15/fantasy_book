class Player < ActiveRecord::Base

  belongs_to :sport
  has_many :players_as_player1, class_name: "Prop", foreign_key: "player1_id"
  has_many :players_as_player2, class_name: "Prop", foreign_key: "player2_id"
  has_many :players_as_player3, class_name: "Prop", foreign_key: "player3_id"
  has_many :players_as_player4, class_name: "Prop", foreign_key: "player4_id"


end
