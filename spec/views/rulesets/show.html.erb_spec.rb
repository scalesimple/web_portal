require 'spec_helper'

describe "rulesets/show" do
  before(:each) do
    @ruleset = assign(:ruleset, stub_model(Ruleset))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
