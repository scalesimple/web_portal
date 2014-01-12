require 'spec_helper'

describe "accounts/edit" do
  before(:each) do
    @account = assign(:account, stub_model(Account,
      :name => "MyString",
      :company_name => "MyString",
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :postal_code => "MyString",
      :primary_contact => "MyString",
      :primary_contact_email => "MyString",
      :primary_phone => "MyString",
      :secondary_phone => "MyString"
    ))
  end

  it "renders the edit account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => accounts_path(@account), :method => "post" do
      assert_select "input#account_name", :name => "account[name]"
      assert_select "input#account_company_name", :name => "account[company_name]"
      assert_select "input#account_address", :name => "account[address]"
      assert_select "input#account_city", :name => "account[city]"
      assert_select "input#account_state", :name => "account[state]"
      assert_select "input#account_postal_code", :name => "account[postal_code]"
      assert_select "input#account_primary_contact", :name => "account[primary_contact]"
      assert_select "input#account_primary_contact_email", :name => "account[primary_contact_email]"
      assert_select "input#account_primary_phone", :name => "account[primary_phone]"
      assert_select "input#account_secondary_phone", :name => "account[secondary_phone]"
    end
  end
end
