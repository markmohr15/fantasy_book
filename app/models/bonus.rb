# == Schema Information
#
# Table name: bonuses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :integer
#  pending    :integer
#  kind       :string(255)
#  rollover   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :integer
#

class Bonus < ActiveRecord::Base
  include AASM, StorageConversions

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true

  store_cents :amount, :pending

  enum state: [ :Pending, :Complete, :Expired ]

  before_validation :set_pending

  def set_pending
    self.pending = self.amount
  end

  aasm column: :state do
    state :Pending, initial: true

    event :complete_bonus do
      transitions from: :Pending, to: :Complete
    end

    state :Complete

    event :expire_bonus do
      transitions from: :Pending, to: :Expired
    end

    state :Expired

  end
end
