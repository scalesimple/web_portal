require 'spec_helper'

describe "rules/index" do
  before(:each) do
    assign(:rules, [
      stub_model(Rule),
      stub_model(Rule)
    ])
  end

  it "renders a list of rules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
