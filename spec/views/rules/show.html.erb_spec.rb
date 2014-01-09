require 'spec_helper'

describe "rules/show" do
  before(:each) do
    @rule = assign(:rule, stub_model(Rule))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
