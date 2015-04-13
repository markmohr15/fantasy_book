require 'rails_helper'

RSpec.describe Deposit, type: :model do
  let(:bonus_code) { create :bonus_code}
  let(:user) { create :user}
  let(:deposit) { Deposit.create(user_id: user.id,
    bonus_code: bonus_code.code, amount: 50000)}

  it "updates the user's balance with the deposit amount" do
    expect(deposit.user.balance).to eq 150000
  end

  it "creates a bonus with the bonus code" do
    bonus = deposit.user.bonuses.first
    expect(deposit.user.bonuses.count).to eq 1
    expect(bonus.bonus_code.code).to eq bonus_code.code
    expect(bonus.rollover).to eq bonus_code.rollover
    expect(bonus.amount).to eq deposit.amount * bonus_code.percentage / 100.0
  end

end
