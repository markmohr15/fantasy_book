require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user}
  let(:admin) { create :admin}
  let(:superadmin) { create :superadmin}
  let(:house) { create :house}

  it "has a valid factory" do
    expect(user).to be_valid
    expect(admin).to be_valid
    expect(superadmin).to be_valid
    expect(house).to be_valid
  end

  it "is a player if role equals player" do
    expect(user.player?).to eq true
    expect(admin.player?).to eq false
    expect(superadmin.player?).to eq false
    expect(house.player?).to eq false
  end

end
