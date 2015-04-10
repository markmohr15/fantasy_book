# == Schema Information
#
# Table name: transfers
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  amount      :integer
#  state       :integer          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_transfers_on_receiver_id  (receiver_id)
#  index_transfers_on_sender_id    (sender_id)
#

class Transfer < ActiveRecord::Base
  include StorageConversions

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :amount, presence: true

  enum state: [ :Pending, :Approved, :Rejected ]

  store_cents :amount

  after_create :deduct, :notify
  after_save :process

  def deduct
    self.sender.balance -= self.amount
    self.sender.save
  end

  def notify
    if self.sender.email_notif?
      MailgunMailer.transfer_request(self).deliver_later
    end
    if self.sender.sms_notif?
      Text.transfer_request(self)
    end
  end

  def process
    if self.state == "Approved"
      self.receiver.balance += self.amount
      self.receiver.save
      if self.sender.email_notif?
        MailgunMailer.transfer_approved(self).deliver_later
      end
      if self.sender.sms_notif?
        Text.transfer_approved(self)
      end
      if self.receiver.email_notif?
        MailgunMailer.transfer_sent(self).deliver_later
      end
      if self.receiver.sms_notif?
        Text.transfer_sent(self)
      end
    elsif self.state == "Rejected"
      self.sender.balance += self.amount
      self.sender.save
      if self.sender.email_notif?
        MailgunMailer.transfer_rejected(self).deliver_later
      end
      if self.sender.sms_notif?
        Text.transfer_rejected(self)
      end
    end
  end

  def side(user)
    if self.sender == user
      "Send"
    else
      "Receive"
    end
  end

  def counterparty(user)
    if self.sender == user
      self.receiver.username
    else
      self.sender.username
    end
  end
end
