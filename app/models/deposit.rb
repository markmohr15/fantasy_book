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

class Deposit < ActiveRecord::Base
  include StorageConversions

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true

  store_cents :amount

  after_create :bonus_check

  def bonus_check
    return if self.bonus_code.nil?
    bc = BonusCode.find_by code: self.bonus_code
    return if bc.nil?
    #check for eligibility here
    Bonus.create(user_id: self.user_id, amount: self.amount * bc.precentage / 100.0,
     bonus_code_id: bc.id)
  end
end
