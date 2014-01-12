require 'spec_helper'

describe "tokens/edit" do
  before(:each) do
    @token = assign(:token, stub_model(Token))
  end

  it "renders the edit token form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", token_path(@token), "post" do
    end
  end
end
