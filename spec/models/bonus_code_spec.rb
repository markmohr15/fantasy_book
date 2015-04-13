require 'rails_helper'

RSpec.describe BonusCode, type: :model do
  let(:bc) { create :bonus_code}

  it "has a valid factory" do
    expect(bc).to be_valid
  end
end
