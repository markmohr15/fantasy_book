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

class Transfer < ActiveRecord::Base
  include StorageConversions

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :amount, presence: true

  enum state: [ :Pending, :Approved, :Rejected ]

  store_cents :amount

  after_create :deduct
  after_save :process

  def deduct
    self.sender.balance -= self.amount
    self.sender.save
  end

  def process
    if self.state == "Approved"
      self.receiver.balance += self.amount
      self.receiver.save
    elsif self.state == "Rejected"
      self.sender.balance += self.amount
      self.sender.save
    end
  end

  def side(user)
    if self.sender == user
      "Send"
    else
      "Receive"
    end
  end
end
