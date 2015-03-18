require 'rails_helper'

RSpec.describe Prop, type: :model do
  let(:prop) { create :prop_with_prop_choices}

  it "has a valid factory" do
    expect(prop).to be_valid
  end

  it "has two prop choices" do
    expect(prop.prop_choices.count).to eq 2
  end
end
