require 'spec_helper'

describe "rules/edit" do
  before(:each) do
    @rule = assign(:rule, stub_model(Rule))
  end

  it "renders the edit rule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rules_path(@rule), :method => "post" do
    end
  end
end
