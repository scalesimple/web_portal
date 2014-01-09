require 'spec_helper'

describe "rulesets/edit" do
  before(:each) do
    @ruleset = assign(:ruleset, stub_model(Ruleset))
  end

  it "renders the edit ruleset form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rulesets_path(@ruleset), :method => "post" do
    end
  end
end
