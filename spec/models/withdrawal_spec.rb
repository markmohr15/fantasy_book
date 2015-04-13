require 'rails_helper'

RSpec.describe Withdrawal, type: :model do
  let(:withdrawal) { create :withdrawal}

  it "has a valid factory" do
    expect(withdrawal).to be_valid
  end

  it "deducts the amount from the user's balance" do
    expect(withdrawal.user.balance).to eq 40000
  end

  it "calculates the fee based on the amount" do
    expect(withdrawal.fee).to eq 2100
  end

  it "calculates the net amount" do
    expect(withdrawal.net_amount).to eq 579
  end

  it "returns the money to the user if rejected" do
    withdrawal.state = "Rejected"
    withdrawal.save
    expect(withdrawal.user.balance).to eq 100000
  end

end
