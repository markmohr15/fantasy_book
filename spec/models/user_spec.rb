require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user}
  let(:admin) { create :admin}
  let(:superadmin) { create :superadmin}
  let(:vip) { create :vip}

  it "has a valid factory" do
    expect(user).to be_valid
    expect(admin).to be_valid
    expect(superadmin).to be_valid
    expect(vip).to be_valid
  end

  it "is a player if role equals player" do
    expect(user.player?).to eq true
    expect(admin.player?).to eq false
    expect(superadmin.player?).to eq false
    expect(vip.player?).to eq false
  end

end
