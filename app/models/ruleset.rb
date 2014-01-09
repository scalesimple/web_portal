class Ruleset
  include Mongoid::Document
  include Mongoid::Timestamps


  cattr_accessor :match_types
  attr_accessor :ruleset_template_id
  attr_protected :locked

  @@match_types = %w(ANY ALL NONE)

  field :name, type: String
  field :locked, type: Boolean, :default=>false
  field :default, type: Boolean, :default=>false
  field :status

  belongs_to :account, :index=>true
  has_many :hostnames
  has_many :active_hostnames, :class_name => "Hostname", :foreign_key => "active_ruleset_id"
  embeds_many :rules

  validates :name, :presence=>true
  validates_uniqueness_of :name, :scope => :account_id, :message => " must be unique and that one is already being used"

  before_create :set_status
  before_destroy :check_destroyable

  
  # def self.make_default_rulesets(account)
  #  account.rulesets << Ruleset.new(:name=>"Cache Nothing", :locked=>true, :default=>true)
  #  self.make_cache_everything_ruleset(account)
  #  self.make_cache_everything_ruleset(account)
  # end

  # def self.make_cache_everything_ruleset(account)
  #   r=Ruleset.new(:name=>"Cache Everything", :locked=>true)
  #   account.rulesets << r
  #   rule = Rule.new
  #   rule.match="ALWAYS"
  #   rule.name="Cache Everything for One Day"
  #   rule.set_rule_actions(:set_ttl=>{:value=>1, :unit=>"DAYS"})
  #   r.rules << rule

  # end

  # def self.make_cache_assets_ruleset(account)
  #   r=Ruleset.new(:name=>"Cache Static Assets", :locked=>true)
  #   account.rulesets << r
  #   rule = Rule.new
  #   rule.match="ALWAYS"
  #   rule.name="Cache Static Assets for One Day"
  #   rule.set_rule_actions(:set_ttl=>{:value=>1, :unit=>"DAYS"})
  #   rule.set_conditions(:content_type=>{:value=>"*.js, *.css, *.jpg, *.png, *.gif, *.jpeg"})
  #   r.rules << rule

  # end
  
  def self.templates
    self.where(:locked => true).all
  end

  def publish(hostname_id = nil )
    if self.hostnames.size > 0 #&& self.status != $RULESET_STATUS[:active]
      publish_ruleset(hostname_id)
    else
      self.errors.add(:base,"Sorry either there are no hostnames associated with this ruleset, its already active, or it can not be found")
      return false
    end
  end

  def deactivate
    return if self.active_hostnames.size > 1  # dont deactivate if its active elsewhere
    self.update_attribute(:status,$RULESET_STATUS[:unassigned])
  end

   #TODO HOW DO WE KNOW WHICH HOSTNAMES TO SET ACTIVE ?
  def activate
    self.hostnames.each { |h| h.set_active_ruleset(self) }
    self.update_attribute(:status,$RULESET_STATUS[:active])
    RulesetMailer.ruleset_active(self.account.user.email,self).deliver
  end

  def invalidate
    self.update_attribute(:status,$RULESET_STATUS[:invalid])
    self.hostnames.each { |h| h.reset_pending_ruleset }
  end

  def is_invalid?
     self.status == $RULESET_STATUS[:invalid]
  end

  def locked?
    self.locked == true
  end

  def pending?
    self.status == $RULESET_STATUS[:pending]
  end

  def active?
    self.status == $RULESET_STATUS[:active]
  end

  def unassigned?
    self.status == $RULESET_STATUS[:unassigned]
  end


  def vcl_entries
    h=Hash.new
    h[:ruleset]=[:name=>self.name, :ruleset_id=>self.id]
    h[:hostnames]=self.hostnames.ready_for_vcl.map{|h| {:name=>h.name, :hostname_id=>h.id, :status=>h.status}}
    h[:rules]=self.rules.map{|r| {:name=>r.name, :vcl_conditions=>r.vcl_conditions, :vcl_actions=>r.vcl_actions}}
    h
  end

  def publish_ruleset(hostname_id)
    Rails.logger.info("Pushing to ruleset queue")
    msg = { :action => "generate_vcl", :payload => { :id => self.id, :hostname_id => hostname_id } }.to_json
    MqLib.publish(msg,'jobs.vcl')
  end

  def clone_ruleset
    ruleset2 = self.clone
    ruleset2.name = 'Copy of ' + self.name
    ruleset2.status = $RULESET_STATUS[:unassigned]
    ruleset2
  end

  def reorder(hash)
    Rails.logger.info("HASH : " + hash.inspect.to_s)
    hash.each { |k,v| 
      begin
       self.rules.find(v).update_attribute(:sort_index,k)
      rescue => e 
        Rails.logger.info("Error finding rule to reorder, #{e}")
      end
    }
  end

  def has_geo_rule
    size = 0 
    self.rules.each { |r| size = size + r.conditions.find_all { |c| c.key == "country" && c.valid_condition? }.size  }
    size > 0 ? true : false 
  end

  def has_token_rule
    size = 0 
    self.rules.each { |r| size = size + r.rule_actions.find_all { |ra| ra.key == "validate_token" && ra.valid_rule_action? }.size  }
    size > 0 ? true : false 
  end

 private 

  def set_status
    self.status = $RULESET_STATUS[:unassigned]
  end

  def check_destroyable
    if locked?
      self.errors.add(:base, "Default rulesets cannot be deleted.")
      return false
    end
    if self.hostnames.count > 0
      self.errors.add(:base, "This ruleset belongs to one or more hostnames and cannot be deleted.")
      return false
    end
    return true
  end
end