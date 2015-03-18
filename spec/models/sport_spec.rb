require 'rails_helper'

RSpec.describe Sport, type: :model do
  let(:sport) { create :sport}

  it "has a valid factory" do
    expect(sport).to be_valid
  end
end
