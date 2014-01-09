require 'spec_helper'
require 'ruby-debug'

describe Rule do

  before(:each) do
        Hostname.delete_all
        Ruleset.delete_all
        User.delete_all
        @account = Account.make
        @account2 = Account.make
        @ruleset = Ruleset.make(:name => "Test Ruleset", :account => @account)
        @ruleset2 = Ruleset.make(:name => "Test Ruleset2", :account => @account)
        @hostname = Hostname.create(:account => @account, :name => "www.example.com", :ruleset => @ruleset)
   end

  it 'does not allow me to modify an active ruleset ' do 
    @ruleset.activate 
    rule = Rule.new(:name => "Test Rule")
    @ruleset.rules << rule 
    @ruleset.errors.full_messages.should == false
  end

end