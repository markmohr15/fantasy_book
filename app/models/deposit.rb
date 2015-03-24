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
#

class Deposit < ActiveRecord::Base
  include StorageConversions

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true

  store_cents :amount

  after_create :initial_bonus

  def initial_bonus
    if self.user.deposits.count == 1
      Bonus.create(user_id: self.id, amount: self.amount * 0.10,
        kind: "Initial", rollover: 20)
    end
  end
end
