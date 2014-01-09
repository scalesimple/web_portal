require 'spec_helper'
require 'ruby-debug'

describe Ruleset do
   before(:each) do
        Hostname.delete_all
        Ruleset.delete_all
        User.delete_all
        @account = Account.make
        @ruleset = Ruleset.make(:name => "Test Ruleset", :account => @account)
        @ruleset2 = Ruleset.make(:name => "Test Ruleset2", :account => @account)
        @hostname = Hostname.create(:account => @account, :name => "www.example.com", :ruleset => @ruleset)
        
   end

   it 'does create a default status of unassigned for new rulesets' do
   	 @ruleset.status.should == $RULESET_STATUS[:unassigned]
   end

   it 'does create a status of active when a ruleset is activated' do 
   	 @ruleset.activate
   	 @ruleset.status.should == $RULESET_STATUS[:active]
   end

   it 'does not get set to unassigned when it is active on more than one hostname' do 
      @hostname2 = Hostname.create(:account => @account, :name => "www2.example.com", :ruleset => @ruleset)
      @ruleset.activate
      @hostname.update_attributes(:ruleset_id => @ruleset2.id)
      @ruleset.status.should == $RULESET_STATUS[:active]
   end

   it 'should reset a hostnames pending ruleset to the active one when a ruleset is invalidated' do 
   	 @ruleset.activate
   	 @hostname.reload
   	 (@hostname.ruleset_id == @hostname.active_ruleset_id).should == true 
   	 @hostname.update_attributes(:ruleset_id => @ruleset2.id)
   	 @hostname.ruleset_id.should == @ruleset2.id 
   	 @hostname.active_ruleset_id.should == @ruleset.id 
   	 @ruleset2.invalidate
   	 @hostname.reload
   	 (@hostname.ruleset_id == @hostname.active_ruleset_id).should == true
   end

   pending it 'should return true for has_geo_rule method when the ruleset contains at least 1 geo based rule' do 
   end

end
