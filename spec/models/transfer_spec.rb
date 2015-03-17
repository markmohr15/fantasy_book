require 'rails_helper'

RSpec.describe Transfer, type: :model do
  let(:transfer) { build :transfer}

  it "has a valid factory" do
    expect(transfer).to be_valid
  end

  it "after transfer is Pending it deducts the amount from sender" do
    transfer.save
    expect(transfer.sender.balance).to eq 80000
    expect(transfer.receiver.balance).to eq 100000
  end

  it "after transfer is Approved increases the balance for receiver" do
    expect(transfer.state).to eq "Pending"
    transfer.state = "Approved"
    transfer.save
    expect(transfer.sender.balance).to eq 80000
    expect(transfer.receiver.balance).to eq 120000
  end

  it "returns the money to the sender if transfer is rejected" do
    transfer.save
    expect(transfer.sender.balance).to eq 80000
    expect(transfer.receiver.balance).to eq 100000
    transfer.state = "Rejected"
    transfer.save
    expect(transfer.sender.balance).to eq 100000
    expect(transfer.receiver.balance).to eq 100000
  end

  it "returns the correct side" do
    expect(transfer.side(transfer.sender)).to eq "Send"
    expect(transfer.side(transfer.receiver)).to eq "Receive"
  end

  it "returns the correct counterparty" do
    expect(transfer.counterparty(transfer.sender)).to eq transfer.receiver.username
    expect(transfer.counterparty(transfer.receiver)).to eq transfer.sender.username
  end
end
