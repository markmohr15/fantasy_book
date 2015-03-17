require 'rails_helper'

RSpec.describe PropChoice, type: :model do
  let(:prop_choice) { build :prop_choice}

  it "has a valid factory" do
    expect(prop_choice).to be_valid
  end
end
