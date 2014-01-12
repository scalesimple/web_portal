require 'spec_helper'

describe "hostnames/index" do
  before(:each) do
    assign(:hostnames, [
      stub_model(Hostname),
      stub_model(Hostname)
    ])
  end

  it "renders a list of hostnames" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
