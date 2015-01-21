# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  address                :string(255)
#  phone                  :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  country                :string(255)
#  zip                    :string(255)
#  role                   :integer          default("1")
#  name                   :string(255)
#  balance                :integer          default("0")
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, if: :player?
  validates :username, uniqueness: true, if: :player?
  validates :address, presence: true, if: :player?
  validates :city, presence: true, if: :player?
  validates :state, presence: true, if: :player?
  validates :zip, presence: true, if: :player?
  validates :country, presence: true, if: :player?
  validates :name, presence: true

  has_many :wagers

  enum role: [ :admin, :player ]

  def player?
    role == "player"
  end

end
