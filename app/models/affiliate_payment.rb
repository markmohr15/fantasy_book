# == Schema Information
#
# Table name: affiliate_payments
#
#  id           :integer          not null, primary key
#  amount       :integer
#  state        :integer
#  affiliate_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AffiliatePayment < ActiveRecord::Base
  include StorageConversions

  belongs_to :user
  belongs_to :affiliate, class_name: "User"

  validates :amount, presence: true
  validates :affiliate_id, presence: true
  validates :user_id, presence: true

  store_cents :amount

  enum state: [ :Pending, :Approved, :Rejected ]

  after_save :make_payment

  def make_payment
    if self.state == "Approved"
      self.affiliate.balance += self.amount
      self.affiliate.save
    end
  end
end
