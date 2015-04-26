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
#  email_notif            :boolean          default("1")
#  sms_notif              :boolean          default("0")
#  referral_code          :string(255)
#  affiliate              :boolean          default("0")
#  stripe_customer_id     :string(255)
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

  has_many :wagers
  has_many :props
  has_many :transfers_as_sender, class_name: "Transfer", foreign_key: "sender_id"
  has_many :transfers_as_receiver, class_name: "Transfer", foreign_key: "receiver_id"
  has_many :credits
  has_many :credits_as_admin, class_name: "Credit", foreign_key: "admin_id"
  has_many :deposits
  has_many :withdrawals
  has_many :bonuses
  has_many :affiliate_payments
  has_many :affiliate_payments_as_affiliate, class_name: "AffiliatePayment", foreign_key: "affiliate_id"

  validates :username, presence: true,  if: :player?
  validates :username, uniqueness: true, case_sensitive: false, if: :player?
  validates :email, presence: true, if: :player?
  validates :email, uniqueness: true, case_sensitive: false
  validates :address, presence: true, if: :player?
  validates :city, presence: true, if: :player?
  validates :state, presence: true, if: :player?
  validates :zip, presence: true, if: :player?
  validates :country, presence: true, if: :player?
  validates :name, presence: true
  validates :phone, presence: true, if: :player?

  store_cents :balance
  accepts_nested_attributes_for :credits

  enum role: [ :admin, :player, :superadmin, :vip ]

  before_create :verify_referral_code

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

  def verify_referral_code
    return if self.referral_code.blank?
    rc = User.find_by username: self.referral_code
    if rc.nil?
      self.referral_code = nil
    end
  end

  def self.total_player_balances
    players = User.where(role:1)
    counter = 0
    players.each do |player|
      counter += player.balance_dollars
    end
    counter
  end

  def has_affiliate?
    if self.referral_code.blank?
      false
    else
      referrer = User.find_by username: self.referral_code
      if referrer.affiliate?
        true
      else
        false
      end
    end
  end

end
