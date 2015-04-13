require 'rails_helper'

RSpec.describe AffiliatePayment, type: :model do
  let(:ap) { create :affiliate_payment}

  it "has a valid factory" do
    expect(ap).to be_valid
  end

  it "after AffiliatePayment is Approved increases the balance for affiliate" do
    expect(ap.state).to eq "Pending"
    ap.state = "Approved"
    ap.save
    expect(ap.affiliate.balance).to eq 120000
  end

end
