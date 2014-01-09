require 'spec_helper'

describe "rules/new" do
  before(:each) do
    assign(:rule, stub_model(Rule).as_new_record)
  end

  it "renders new rule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rules_path, :method => "post" do
    end
  end
end
