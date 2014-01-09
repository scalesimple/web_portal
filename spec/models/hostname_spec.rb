require 'spec_helper'
require 'ruby-debug'

describe Hostname do

  before(:each) do
        Hostname.delete_all
        Ruleset.delete_all
        User.delete_all
        @account = Account.make
        @account2 = Account.make
        @ruleset = Ruleset.make(:name => "Test Ruleset", :account => @account)
        @ruleset2 = Ruleset.make(:name => "Test Ruleset2", :account => @account)
        @invalid_ruleset = Ruleset.make(:name => "Invalid Ruleset", :account => @account)
        @invalid_ruleset.invalidate
        @hostname = Hostname.create(:account => @account, :name => "www.example.com", :ruleset => @ruleset)
        @hostname_no_ruleset = Hostname.create(:account => @account, :name => "www.example.com")
   end

   it 'does create a default ruleset status of unassigned for new rulesets' do
      @hostname.ruleset.status.should == $RULESET_STATUS[:unassigned]
      true.should == true 
   end

   it 'does have a blank active ruleset when first created' do
   	 @hostname.active_ruleset.should == nil
   end

   it 'does not modify the status of rulesets that are already active on other hosts when a hostname gets a new ruleset' do
   	 @ruleset.activate
   	 @hostname2 = Hostname.create(:account => @account, :name => "www2.example.com", :ruleset => @ruleset)
   	 @hostname2.update_attributes(:ruleset_id => @ruleset2.id)
   	 @ruleset2.activate
     @ruleset.status.should == $RULESET_STATUS[:active]
   end

   it 'does create a default hostname status of PENDING' do
      @hostname.status.should == $HOSTNAME_STATUS[:pending]
   end

   it 'does have a status of active when it is activated' do 
   	@hostname.activate
   	@hostname.status.should == $HOSTNAME_STATUS[:active]
   end

   it 'does not allow you to save with an invalid hostname for origin' do 
   	@hostname = Hostname.new(:account => @account, :name => "www.example.com", :origin => "www.", :ruleset => @ruleset)
   	@hostname.valid?.should == false 
   end

   it 'does not let me use a ruleset that has an invalid status when creating hostnames' do 
    @hostname = Hostname.create(:account => @account, :name => "www-invalid.example.com", :ruleset => @invalid_ruleset)
   	@hostname.valid?.should == false 
   end
   
   it 'does not let me use a ruleset that has an invalid status when updating hostnames' do 
    @hostname.update_attributes(:ruleset_id => @invalid_ruleset.id)
   	@hostname.valid?.should == false 
   end

   it 'should not let me save a hostname without a ruleset' do 
    @hostname_no_ruleset.valid?.should == false 
   end


end
