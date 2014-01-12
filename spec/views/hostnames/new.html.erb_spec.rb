require 'spec_helper'

describe "hostnames/new" do
  before(:each) do
    assign(:hostname, stub_model(Hostname).as_new_record)
  end

  it "renders new hostname form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hostnames_path, :method => "post" do
    end
  end
end
