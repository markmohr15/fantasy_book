require 'rails_helper'

RSpec.describe PropChoice, type: :model do
  let(:prop) { create :prop_with_prop_choices}
  let(:prop_choice) { prop.prop_choices.first}
  let(:prop_choice2) { prop.prop_choices.last}
  let(:player) { create :player}
  let(:player2) { create :player2}

  it "has a valid factory" do
    expect(prop).to be_valid
    expect(prop_choice).to be_valid
    expect(prop_choice2).to be_valid
    expect(player).to be_valid
    expect(player2).to be_valid
  end

  it "displays the line correctly" do
    prop_choice.available = 0
    expect(prop_choice.display_line).to eq ""
    prop_choice.available = 1
    expect(prop_choice.display_line).to eq prop.opt1_spread_line.to_s + " FP " + prop_choice.odds_juice.to_s
    prop_choice2.available = 0
    expect(prop_choice2.display_line).to eq ""
    prop_choice2.available = 1
    expect(prop_choice2.display_line).to eq prop.opt2_spread_line.to_s + " FP " + prop_choice2.odds_juice.to_s
  end

  it "displays a prop choice's name correctly" do
    expect(player.id).to eq 1
    expect(player2.id).to eq 2
    expect(prop_choice.name).to eq player.name + ", " + player2.name
  end

  it "displays a prop_choice's proposition correctly" do
    expect(player.id).to eq 1
    expect(player2.id).to eq 2
    expect(prop_choice.display_proposition).to eq player.name + ", " + player2.name + " Vs. " + player.name + ", " + player2.name
  end

end
