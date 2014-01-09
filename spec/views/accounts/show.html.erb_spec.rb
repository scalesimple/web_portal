require 'spec_helper'

describe "accounts/show" do
  before(:each) do
    @account = assign(:account, stub_model(Account,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Company Name/)
    rendered.should match(/Address/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Postal Code/)
    rendered.should match(/Primary Contact/)
    rendered.should match(/Primary Contact Email/)
    rendered.should match(/Primary Phone/)
    rendered.should match(/Secondary Phone/)
  end
end
