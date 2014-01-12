require 'spec_helper'

describe "hostnames/show" do
  before(:each) do
    @hostname = assign(:hostname, stub_model(Hostname))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
