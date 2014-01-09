require 'spec_helper'

describe "hostnames/edit" do
  before(:each) do
    @hostname = assign(:hostname, stub_model(Hostname))
  end

  it "renders the edit hostname form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hostnames_path(@hostname), :method => "post" do
    end
  end
end
