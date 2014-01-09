require 'spec_helper'

describe "purges/show" do
  before(:each) do
    @purge = assign(:purge, stub_model(Purge,
      :hostname => "Hostname",
      :path => "Path",
      :account_id => "Account"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Hostname/)
    rendered.should match(/Path/)
    rendered.should match(/Account/)
  end
end
