require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { build :player}

  it "has a valid factory" do
    expect(player).to be_valid
  end
end
