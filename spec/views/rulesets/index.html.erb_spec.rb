require 'spec_helper'

describe "rulesets/index" do
  before(:each) do
    assign(:rulesets, [
      stub_model(Ruleset),
      stub_model(Ruleset)
    ])
  end

  it "renders a list of rulesets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
