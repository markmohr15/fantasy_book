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
  include StorageConversions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true,  if: :player?
  validates :username, uniqueness: true, case_sensitive: false, if: :player?
  validates :address, presence: true, if: :player?
  validates :city, presence: true, if: :player?
  validates :state, presence: true, if: :player?
  validates :zip, presence: true, if: :player?
  validates :country, presence: true, if: :player?
  validates :name, presence: true

  has_many :wagers
  has_many :props
  has_many :transfers_as_sender, class_name: "Transfer", foreign_key: "sender_id"
  has_many :transfers_as_receiver, class_name: "Transfer", foreign_key: "receiver_id"
  has_many :credits
  has_many :credits_as_admin, class_name: "Credit", foreign_key: "admin_id"

  enum role: [ :admin, :player, :superadmin, :vip ]

  store_cents :balance
  accepts_nested_attributes_for :credits

  attr_accessor :login

  def player?
    role == "player"
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
