require 'rails_helper'

RSpec.describe Wager, type: :model do
  let(:prop) { create :prop_with_prop_choices}
  let(:user) { create :user}
  let(:wager) {Wager.new(prop_id: prop.id, user_id: user.id,
  risk: 11000, prop_choice_id: prop.prop_choices.first.id,
  odds: prop.prop_choices.first.odds, spread: prop.opt1_spread )}

  it "has a valid factory" do
    expect(wager).to be_valid
  end

  it "is a player" do
    expect(wager.player?).to eq true
  end

  it "creates a contra wager with the correct attributes for a VIP account" do
    wager.save
    expect(prop.user.wagers.count).to eq 1
    expect(prop.user.wagers.first.risk).to eq wager.win
    expect(prop.user.wagers.first.win).to eq wager.risk
    expect(prop.user.wagers.first.prop_choice).to eq prop.prop_choices.last
  end

  it "reduces the available amount for the prop choice" do
    wager.save
    expect(prop.prop_choices.first.available).to eq 39000
  end

  it "calculates the correct win amount" do
    wager.save
    expect(wager.win).to eq 10000
  end

  it "stores risk and win amounts as cents, displays in dollars" do
    wager.risk_dollars = 345.67
    wager.odds = 100
    wager.save
    expect(wager.risk).to eq 34567
    expect(wager.win).to eq 34567
  end

  it "reduces the wager's user's balance by the risk amount" do
    wager.save
    expect(wager.user.balance).to eq 89000
  end

  it "transitions from Pending to Won, pays the win, and displays the correct result" do
    expect(wager.state).to eq "Pending"
    wager.win_wager!
    expect(wager.state).to eq "Won"
    expect(wager.user.balance).to eq 110000
    expect(wager.result).to eq 100
  end

  it "transitions from Pending to Lost and displays the correct result" do
    expect(wager.state).to eq "Pending"
    wager.lose_wager!
    expect(wager.state).to eq "Lost"
    expect(wager.user.balance).to eq 89000
    expect(wager.result).to eq -110
  end

  it "transitions from Pending to Push, returns the risk, and displays the correct result" do
    expect(wager.state).to eq "Pending"
    wager.push_wager!
    expect(wager.state).to eq "Push"
    expect(wager.user.balance).to eq 100000
    expect(wager.result).to eq 0
  end

  it "transitions from Pending to No Action, returns the risk, and displays the correct result" do
    expect(wager.state).to eq "Pending"
    wager.void_wager!
    expect(wager.state).to eq "No_Action"
    expect(wager.user.balance).to eq 100000
    expect(wager.result).to eq 0
  end

  it "can ungrade a winning wager" do
    wager.save
    expect(wager.user.balance).to eq 89000
    wager.win_wager!
    expect(wager.user.balance).to eq 110000
    wager.ungrade_wager
    expect(wager.user.balance).to eq 89000
    expect(wager.state).to eq "Pending"
  end

  it "can ungrade a losing wager" do
    wager.save
    expect(wager.user.balance).to eq 89000
    wager.lose_wager!
    expect(wager.user.balance).to eq 89000
    wager.ungrade_wager
    expect(wager.user.balance).to eq 89000
    expect(wager.state).to eq "Pending"
  end

  it "can ungrade a pushed wager" do
    wager.save
    expect(wager.user.balance).to eq 89000
    wager.push_wager!
    expect(wager.user.balance).to eq 100000
    wager.ungrade_wager
    expect(wager.user.balance).to eq 89000
    expect(wager.state).to eq "Pending"
  end

  it "can ungrade a no actioned wager" do
    wager.save
    expect(wager.user.balance).to eq 89000
    wager.void_wager!
    expect(wager.user.balance).to eq 100000
    wager.ungrade_wager
    expect(wager.user.balance).to eq 89000
    expect(wager.state).to eq "Pending"
  end

end
