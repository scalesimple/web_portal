require 'spec_helper'

describe "purges/index" do
  before(:each) do
    assign(:purges, [
      stub_model(Purge,
        :hostname => "Hostname",
        :path => "Path",
        :account_id => "Account"
      ),
      stub_model(Purge,
        :hostname => "Hostname",
        :path => "Path",
        :account_id => "Account"
      )
    ])
  end

  it "renders a list of purges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Hostname".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
    assert_select "tr>td", :text => "Account".to_s, :count => 2
  end
end
