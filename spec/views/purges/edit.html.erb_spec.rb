require 'spec_helper'

describe "purges/edit" do
  before(:each) do
    @purge = assign(:purge, stub_model(Purge,
      :hostname => "MyString",
      :path => "MyString",
      :account_id => "MyString"
    ))
  end

  it "renders the edit purge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => purges_path(@purge), :method => "post" do
      assert_select "input#purge_hostname", :name => "purge[hostname]"
      assert_select "input#purge_path", :name => "purge[path]"
      assert_select "input#purge_account_id", :name => "purge[account_id]"
    end
  end
end
