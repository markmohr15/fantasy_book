require 'rails_helper'

RSpec.describe MassEmail, type: :model do
  let(:me) { create :mass_email}

  it "has a valid factory" do
    expect(me).to be_valid
  end

  it "sets up two delayed jobs" do
    me.save
    expect(Delayed::Job.count).to eq 2
  end

  it "sets notify to run at the run_at time" do
    me.save
    expect(Delayed::Job.find_by(queue: "Notify").run_at).to eq me.send_at
  end
end
