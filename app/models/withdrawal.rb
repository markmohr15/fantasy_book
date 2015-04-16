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
# Indexes
#
#  index_withdrawals_on_user_id  (user_id)
#

class Withdrawal < ActiveRecord::Base
  include StorageConversions

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true
  validates :kind, presence: true
  validate :balance?, on: :create

  store_cents :amount, :fee

  after_create :deduct, :notify
  after_save :process

  before_save :get_fee

  enum state: [ :Pending, :Approved, :Rejected ]

  def deduct
    self.user.balance -= self.amount
    self.user.save
  end

  def notify
    if self.user.email_notif?
      MailgunMailer.withdrawal_request(self).deliver_later
    end
    #if self.user.sms_notif?
     # Text.withdrawal_request(self)
    #end
  end

  def process
    if self.state == "Approved"
      if self.user.email_notif?
        MailgunMailer.withdrawal_approved(self).deliver_later
      end
      #if self.user.sms_notif?
       # Text.withdrawal_approved(self)
      #end
    elsif self.state == "Rejected"
      self.user.balance += self.amount
      self.user.save
      if self.user.email_notif?
        MailgunMailer.withdrawal_rejected(self).deliver_later
      end
      #if self.user.sms_notif?
       # Text.withdrawal_rejected(self)
      #end
    end
  end

  def get_fee
    self.fee = (self.amount * 0.035).round
  end

  def net_amount
    self.amount_dollars - self.fee_dollars
  end

  def balance?
    return if self.amount.nil?
    if self.amount > self.user.balance
      errors[:base] << "Withdrawal is more than your current balance."
    end
  end
end
