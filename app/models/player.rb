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
# Indexes
#
#  index_players_on_sport_id  (sport_id)
#

class Player < ActiveRecord::Base

  belongs_to :sport

  validates :name, presence: true

end
