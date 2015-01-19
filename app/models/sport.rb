class Sport < ActiveRecord::Base

  has_many :players
  has_many :props

  validates :name, presence: true

end
