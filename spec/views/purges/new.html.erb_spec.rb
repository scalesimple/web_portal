require 'spec_helper'

describe "purges/new" do
  before(:each) do
    assign(:purge, stub_model(Purge,
      :hostname => "MyString",
      :path => "MyString",
      :account_id => "MyString"
    ).as_new_record)
  end

  it "renders new purge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => purges_path, :method => "post" do
      assert_select "input#purge_hostname", :name => "purge[hostname]"
      assert_select "input#purge_path", :name => "purge[path]"
      assert_select "input#purge_account_id", :name => "purge[account_id]"
    end
  end
end
