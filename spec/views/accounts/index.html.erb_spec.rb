require 'spec_helper'

describe "accounts/index" do
  before(:each) do
    assign(:accounts, [
      stub_model(Account,
        :name => "Name",
        :company_name => "Company Name",
        :address => "Address",
        :city => "City",
        :state => "State",
        :postal_code => "Postal Code",
        :primary_contact => "Primary Contact",
        :primary_contact_email => "Primary Contact Email",
        :primary_phone => "Primary Phone",
        :secondary_phone => "Secondary Phone"
      ),
      stub_model(Account,
        :name => "Name",
        :company_name => "Company Name",
        :address => "Address",
        :city => "City",
        :state => "State",
        :postal_code => "Postal Code",
        :primary_contact => "Primary Contact",
        :primary_contact_email => "Primary Contact Email",
        :primary_phone => "Primary Phone",
        :secondary_phone => "Secondary Phone"
      )
    ])
  end

  it "renders a list of accounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Company Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
    assert_select "tr>td", :text => "Primary Contact".to_s, :count => 2
    assert_select "tr>td", :text => "Primary Contact Email".to_s, :count => 2
    assert_select "tr>td", :text => "Primary Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Secondary Phone".to_s, :count => 2
  end
end
