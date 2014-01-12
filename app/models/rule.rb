class Rule
  include Mongoid::Document
  include Mongoid::Timestamps

  cattr_accessor :rule_types, :action_types

  @@rule_types = [
        {:name=>"global", :label=>"Global", :value=>true, :name=>false},
        {:name=>"request_url", :label=>"Request URL", :value=>true, :name=>false},
        {:name=>"client_ip", :label=>"Client IP", :value=>true, :name=>false},
        
    ]
  @@action_types = ["SetTTL","Deny"]

  field :name, type: String
  field :match, type: String
  field :global, type: Boolean, :default=>false  #this is an "always run" rule
  field :sort_index, type: Integer, :default=>1

  embeds_many :conditions
  embeds_many :rule_actions

  validates :match, :presence=>true
  validates :name, :presence=>true
  validates :sort_index, :presence=>true, :numericality=>true

  embedded_in :ruleset 


  before_validation do
    unless (self.match=="ALWAYS") || self.has_valid_conditions?
        self.errors.add(:base, "You must provide at least one condition when 'ALL' or 'ANY' is selected.")
        return false
    end
    unless self.has_valid_rule_actions?
        self.errors.add(:base, "You must provide at least one action to occur when the chosen conditions are met. eg., Cache for 1 Day.")
        return false
    end
    if self.match=="ALWAYS"
        make_default_conditions # clear any preixisting conditions
    end
    validate_client_ip
    validate_single_action
    validate_ruleset_status
    validate_no_empty_spaces
    true
  end

  before_create :set_sort_index


  def global?
    self.global && self.global == true
  end

 

  def needs_acl?
    self.conditions.collect { |c| c.key == 'client_ip' && !c.value.blank? }.include?(true)
  end
  
  # Does this rule have any valid conditions
  def has_valid_conditions?
    self.conditions.select{|c| c.valid_condition?}.length > 0
  end

  # List all valid conditions
  def valid_conditions
    self.conditions.select{|c| c.valid_condition?}
  end

  # Does this rule have any valid actions
  def has_valid_rule_actions?
    self.rule_actions.select{|r| r.valid_rule_action?}.length > 0
  end

  def is_a_valid_rule?
    self.has_valid_rule_actions? && ((self.match=="ALWAYS") || self.has_valid_conditions?)
  end

  # List all valid rule actions
  def valid_rule_actions
    self.rule_actions.select{|r| r.valid_rule_action?}
  end

  # Textual display of all conditions
  def conditions_to_text
    return "ALWAYS" if self.match=="ALWAYS" || !self.has_valid_conditions?
    op = self.match=="ALL" ? " AND " : " OR "
    self.valid_conditions.map{|c| c.to_text}.compact.join(op)
  end

  # Textual display of all actions
  def rule_actions_to_text
    op = " AND "
    self.valid_rule_actions.map{|r| r.to_text }.compact.join(op)
  end

  def vcl_functions
    self.rule_actions.collect { |ra| ra.vcl_functions }.flatten.uniq.compact
  end

  # Actions array for VCL
  def vcl_actions
    return [] unless self.has_valid_rule_actions?
    self.rule_actions.map{|r| r.vcl_action}.compact
  end

  # Actions array for VCL
  def vcl_conditions
    return [] unless self.has_valid_conditions? || (self.match=="ALWAYS")
    return {:match=>self.match, :conditions=>self.match=="ALWAYS" ? nil : self.valid_conditions.map{|c| c.vcl_condition}.compact} 
  end


  # Set conditions from parameters on form submission
  def set_conditions(conditions_hash)
    self.make_default_conditions if self.conditions.blank?
    self.conditions.each do |condition|
        p=conditions_hash[condition.key.to_sym]
        condition.new_record? ? condition.assign_attributes(p) : condition.update_attributes(p) 
    end
  end

  # Set actions from parameters on form submission
  def set_rule_actions(actions_hash)
    self.make_default_rule_actions if self.rule_actions.blank?
    self.rule_actions.each do |rule_action|
        p=actions_hash[rule_action.key.to_sym]
        rule_action.new_record? ? rule_action.assign_attributes(p) : rule_action.update_attributes(p)
    end
  end

  # Generate a default set of conditions
  def make_default_conditions
    Condition.conditionals.keys.each do |k|
        self.conditions << Condition.new(:key=>k.to_s)
    end
  end

  # Generate a default set of actions
  def make_default_rule_actions
    RuleAction.actionables.keys.each do |k|
        self.rule_actions << RuleAction.new(:key=>k.to_s)
    end
  end


  private

   def set_sort_index
    return 0 if self.global?
    self.sort_index = self.ruleset.rules.order_by(sort_index: -1).limit(1).first.sort_index + 1
   end   

   def validate_client_ip
    return true unless self.needs_acl?
    self.conditions.collect { |c|
      next unless c.key == 'client_ip' && !c.value.blank?
      c.value.split(',').each { |ip| 
        begin
          IPAddress.parse(ip.gsub(/\s+/,''))
        rescue => e
          self.errors.add(:base, "Invalid IP Address format used for client ip, #{e}")
          return false
        end
      }
    }
    return true
  end

  def validate_single_action
    size = self.rule_actions.find_all { |a| a[:type] == 'SV' || a[:type] == 'SB'}.find_all { |a2| a2 == true}.size 
    if (size > 1 && size != 0)
      errors.add(:base, "You can not choose multiple single action types")
      return false
    else
      true
    end
  end

  def validate_ruleset_status
    if self.ruleset.active?
      errors.add(:base, "Sorry you can not modify rules to an active ruleset")
      return false
    else
      true
    end
  end

  def validate_no_empty_spaces
    self.rule_actions.each { |ra| 
      next unless !ra.value.blank? && ra.key.in?(['remove_cookie','remove_header'])
      if !ra.value.match(/\s+/).nil?
        errors.add(:base,"You can not have any spaces in Remove Cookie or Remove Header")
        return false
      end
    }
    true
  end

end


