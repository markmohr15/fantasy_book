# == Schema Information
#
# Table name: withdrawals
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :integer
#  kind       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :integer          default("0")
#  fee        :integer
#

class Withdrawal < ActiveRecord::Base
  include StorageConversions

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true
  validates :kind, presence: true
  validate :balance?, on: :create

  store_cents :amount, :fee

  after_create :deduct
  after_save :process

  before_save :get_fee

  enum state: [ :Pending, :Approved, :Rejected ]

  def deduct
    self.user.balance -= self.amount
    self.user.save
  end

  def process
    if self.state == "Approved"
      MailgunMailer.withdrawal_approved(self).deliver_later
    elsif self.state == "Rejected"
      self.user.balance += self.amount
      self.user.save
      MailgunMailer.withdrawal_rejected(self).deliver_later
    end
  end

  def net_amount
    self.amount_dollars - self.fee_dollars
  end

  def get_fee
    self.fee = (self.amount * 0.035).round
  end

  def balance?
    return if self.amount.nil?
    if self.amount > self.user.balance
      errors[:base] << "Withdrawal is more than your current balance."
    end
  end
end
