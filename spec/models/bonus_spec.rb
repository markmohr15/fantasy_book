require 'rails_helper'

RSpec.describe Bonus, type: :model do
  let(:user) { create :user}
  let(:bonus) { create :bonus}
  let(:bonus2) { Bonus.create(user_id: user.id, amount: 10000,
    rollover: 20)}

  it "has a valid factory" do
    expect(bonus).to be_valid
  end

  it "sets the correct bonus amounts" do
    expect(bonus.rollover).to eq 20
    expect(bonus.exp_date).to eq Date.today + bonus.bonus_code.length.days
    expect(bonus.pending).to eq 20000
    expect(bonus2.pending).to eq 10000
  end

  it "shows description correctly" do
    expect(bonus.description).to eq bonus.bonus_code.code
    expect(bonus2.description).to eq "Other"
  end

  it "calculates the earned amount correctly" do
    expect(bonus2.earned).to eq 0
    bonus2.pending = 2400
    bonus2.released = 7000
    expect(bonus2.earned).to eq 6
  end

  it "processes bonus amounts based on wagers" do
    bonus2.process_bonus(40000)
    expect(bonus2.pending).to eq 8000
    bonus2.save
    expect(bonus2.released).to eq 2000
  end

end
