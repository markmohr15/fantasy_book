require 'rails_helper'

RSpec.describe Wager, type: :model do
  let(:prop) { create :prop_with_prop_choices}
  let(:user) { create :user}
  let(:wager) {Wager.create(prop_id: prop.id, user_id: user.id,
  risk: 11000, prop_choice_id: prop.prop_choices.first.id,
  odds: prop.prop_choices.first.odds, spread: prop.opt1_spread )}

  it "is a player" do
    expect(wager.player?).to eq true
  end

  it "creates a contra wager for a house account" do
    wager.save
    expect(prop.user.wagers.count).to eq 1
  end

  it "reduces the available amount for the prop choice" do
    wager.save
    expect(prop.prop_choices.first.available).to eq 39000
  end
end
