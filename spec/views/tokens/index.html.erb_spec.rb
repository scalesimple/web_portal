require 'spec_helper'

describe "tokens/index" do
  before(:each) do
    assign(:tokens, [
      stub_model(Token),
      stub_model(Token)
    ])
  end

  it "renders a list of tokens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
