# == Schema Information
#
# Table name: sports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sport < ActiveRecord::Base

  has_many :players
  has_many :props

  validates :name, presence: true

  def has_active_matchups?
    Prop.where(sport_id: self.id, state: 1).exists?
  end

end
