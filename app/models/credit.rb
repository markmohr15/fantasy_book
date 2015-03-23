# == Schema Information
#
# Table name: credits
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  amount     :integer
#  note       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Credit < ActiveRecord::Base
  include StorageConversions

  belongs_to :user
  belongs_to :admin, class_name: "User"
  validates :admin_id, presence: true
  validates :amount, presence: true
  validates :user_id, presence: true

  store_cents :amount

  after_create :add_credit

  def add_credit
    self.user.balance += self.amount
    self.user.save
  end

end
