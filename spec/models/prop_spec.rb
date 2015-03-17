require 'rails_helper'

RSpec.describe Prop, type: :model do
  let(:prop) { build :prop}

  it "has a valid factory" do
    expect(prop).to be_valid
  end
end
