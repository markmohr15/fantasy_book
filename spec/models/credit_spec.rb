require 'rails_helper'

RSpec.describe Credit, type: :model do
  let(:credit) { create :credit}

  it "has a valid factory" do
    expect(credit).to be_valid
  end

  it "updates the user's balance with the credit amount" do
    expect(credit.user.balance).to eq 104000
  end
end
