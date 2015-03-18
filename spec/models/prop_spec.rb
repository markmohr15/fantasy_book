require 'rails_helper'

RSpec.describe Prop, type: :model do
  let(:prop) { create :prop_with_prop_choices }
  let(:user) { create :user }
  let(:wager) {Wager.new(prop_id: prop.id, user_id: user.id,
  risk: 11000, prop_choice_id: prop.prop_choices.first.id,
  odds: prop.prop_choices.first.odds, spread: prop.opt1_spread )}

  it "has a valid factory" do
    expect(prop).to be_valid
  end

  it "has two prop choices" do
    expect(prop.prop_choices.count).to eq 2
  end

  it "displays spreads correctly using display_line" do
    prop.opt1_spread = 5
    expect(prop.opt1_spread_line).to eq "+5"
    prop.opt1_spread = 5.5
    expect(prop.opt1_spread_line).to eq "+5.5"
    prop.opt1_spread = 0
    expect(prop.opt1_spread_line).to eq "Pk"
    prop.opt1_spread = -5
    expect(prop.opt1_spread_line).to eq -5
    prop.opt1_spread = -5.5
    expect(prop.opt1_spread_line).to eq -5.5
  end

  it "calculates opt2_spread based on opt1_spread" do
    prop.opt1_spread = 5
    prop.save
    expect(prop.opt2_spread_line).to eq -5
    prop.opt1_spread = 5.5
    prop.save
    expect(prop.opt2_spread_line).to eq -5.5
    prop.opt1_spread = 0
    prop.save
    expect(prop.opt2_spread_line).to eq "Pk"
    prop.opt1_spread = -5
    prop.save
    expect(prop.opt2_spread_line).to eq "+5"
    prop.opt1_spread = -5.5
    prop.save
    expect(prop.opt2_spread_line).to eq "+5.5"
  end

  it "transitions correctly through prop states" do
    prop.pause_prop!
    expect(prop.state).to eq "Offline"
    prop.allow_wagering!
    expect(prop.state).to eq "Open"
    prop.close_prop!
    expect(prop.state).to eq "Closed"
    prop.grade_prop!
    expect(prop.state).to eq "Graded"
    prop.regrade_prop!
    expect(prop.state).to eq "Regrade"
  end

  it "grades the prop when it is closed and has a winner and regrades if necessary" do
    wager.save
    prop.save
    expect(prop.wagers.first.state).to eq "Pending"
    expect(prop.state).to eq "Open"
    prop.state = 2
    prop.save
    expect(prop.state).to eq "Closed"
    expect(prop.wagers.first.state).to eq "Pending"
    prop.winner = 0
    prop.save
    expect(prop.state).to eq "Graded"
    expect(prop.wagers.first.state).to eq "Won"
    prop.state = 4
    prop.winner = 1
    prop.save
    expect(prop.state).to eq "Graded"
    expect(prop.wagers.first.state).to eq "Lost"
  end
end
