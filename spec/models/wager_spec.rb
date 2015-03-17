require 'rails_helper'

RSpec.describe Wager, type: :model do
  let(:wager) { build :wager}

  it "has a valid factory" do
    expect(wager).to be_valid
  end
end
