require 'spec_helper'

describe "rulesets/new" do
  before(:each) do
    assign(:ruleset, stub_model(Ruleset).as_new_record)
  end

  it "renders new ruleset form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rulesets_path, :method => "post" do
    end
  end
end
