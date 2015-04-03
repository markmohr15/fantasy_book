# == Schema Information
#
# Table name: deposits
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :integer
#  method     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bonus_code :string(255)
#
# Indexes
#
#  index_deposits_on_user_id  (user_id)
#

class Deposit < ActiveRecord::Base
  include StorageConversions

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true

  store_cents :amount

  after_create :bonus, :affiliate_and_refer_a_friend

  def bonus
    return if self.bonus_code.nil?
    bc = BonusCode.find_by code: self.bonus_code
    return if bc.nil?
    Bonus.create(user_id: self.user_id, amount: self.amount * bc.percentage / 100.0,
     bonus_code_id: bc.id)
  end

  def affiliate_and_refer_a_friend
    referrer = User.find_by username: self.user.referral_code
    return if referrer.nil?
    if referrer.affiliate?
      if Deposit.where(user_id: self.user_id).count == 1
        AffiliatePayment.create(amount: self.amount * 0.10, affiliate_id: referrer.id,
          user_id: self.user_id, state: "Pending")
      else
        AffiliatePayment.create(amount: self.amount * 0.03, affiliate_id: referrer.id,
          user_id: self.user_id, state: "Approved")
      end
    else
      if Deposit.where(user_id: self.user_id).count == 1
        Bonus.create(user_id: referrer.id, amount: self.amount * 0.10,
          bonus_code_id: BonusCode.find_by(code: "Refer-A-Friend").id)
      end
    end
  end

end
