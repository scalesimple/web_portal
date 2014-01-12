class RuleAction
include Mongoid::Document

  # S=Single => No other action can be taken 
  # V=Value => This action has a value associated with it (like a TTL) 
  # U=Units => This value has a unit 
  # N=Name B=Boolean => This value is a true or false , like Deny Request 

  cattr_accessor :actionables
  @@actionables = 
    {
      :do_not_cache=>{:label=>"Do Not Cache", :type=>"SB", :advanced=>false, :vcl_functions => ["vcl_fetch"], :help_text=>"Do not cache at all"},
      :set_ttl=>{:label=>"Cache For", :type=>"VU", :advanced=>false, :vcl_functions => ["vcl_fetch"], :help_text=>"Enter cache duration in Hours, Minutes, Seconds or Days. [0] = unlimited", :units=>%w(HOURS MINUTES SECONDS DAYS), :default=>0},
      :http_redirect => {:label => "HTTP Redirect to", :type => "SV", :advanced=>false, :vcl_functions => ["vcl_recv"], :help_text=>"Redirect to another website"},
      :add_cookie => { :label => "Add Cookie", :type => "NV", :advanced=>false, :vcl_functions => ["vcl_deliver"], :help_text => "Add a cookie to the response"},
      :remove_cookie => {:label => "Remove Request And Response Cookie", :type => "B", :advanced=>false, :vcl_functions => ["vcl_recv","vcl_fetch"], :help_text => "Remove cookie from request and origin response"},
      :deny_request => {:label => "Deny Request", :type => "SB", :advanced=>false , :vcl_functions => ["vcl_recv"], :help_text => "Deny request with an HTTP 403"},
      :add_request_header => { :label => "Add Request Header", :type => "NV", :advanced=>false, :vcl_functions => ["vcl_recv"], :help_text => "Add an HTTP Header to the origin request"},
      :add_response_header => { :label => "Add Response Header", :type => "NV", :advanced=>false, :vcl_functions => ["vcl_deliver"], :help_text => "Add an HTTP Header to the response"},
      :remove_request_header => {:label => "Remove Request Header", :type => "V", :advanced => false, :vcl_functions => ["vcl_recv"], :help_text => "Remove header from request"},
      :remove_response_header => {:label => "Remove Response Header", :type => "V", :advanced => false, :vcl_functions => ["vcl_deliver"], :help_text => "Remove header from response"},
      :validate_token => {:label => "Validate Token", :type => "V", :advanced => true, :vcl_functions => ["vcl_recv"], :help_text => "Require a valid token on this request" }
    }
  
  field :key, type: String
  field :name, type: String
  field :value, type: String
  field :unit, type: String

  embedded_in :rule

  before_validation :validate_actionables

  #before_save :set_token_name

  # looks up definition of rule action by key
  def actionable
    RuleAction.actionables[self.key.to_sym]
  end

  def vcl_functions
    return nil if self.actionable.nil?
    self.actionable[:vcl_functions]
  end

  # is this action a valid action
  def valid_rule_action?
    !self.value.blank?
    #!self.value.blank? && ( (actionable[:type]=="VU") || (actionable[:type] == "SV") || ( (actionable[:type]=="NV") && !self.name.blank?) )
  end

  def to_text
    return nil if !self.valid_rule_action? || self.value == "false"
    op = self.actionable
    if (op[:type]=="VU") && !self.value.blank?
      "#{op[:label]} #{self.value} #{self.unit}"
    elsif (op[:type]=="S")
      "#{op[:label]}"
    elsif (op[:type] == "SV")
      "#{op[:label]} #{self.value}"
    elsif (op[:type] == "SB" || op[:type] == "B")
      "#{op[:label]}"
    elsif (op[:type] == "NV")
      "#{op[:label]} #{self.name} : #{self.value}"
    elsif (op[:type] == "V")
      "#{op[:label]}"
    else
      nil
    end
  end

  def vcl_value
    return nil unless self.valid_rule_action?

    act = self.actionable
    case act[:type]
    when "VU"
        val = act[:data_type]==Integer ? val.to_i :
        case self.unit
        when "SECONDS"
            return self.value.to_i
        when "HOURS"
            return self.value.to_i * 3600
        when "MINUTES"
            return self.value.to_i * 60
        when "DAYS"
            return self.value.to_i * 86400
        end
    else
        return nil
    end
  end

  def vcl_action
    return nil unless self.valid_rule_action?
    act = self.actionable
    case act[:type]
    when "VU"
        {self.key.to_sym=>self.vcl_value}
    else
        nil
    end
  end

  def validate_actionables
    act=self.actionable
    return unless act 
    if act[:type]=~/VU/
        self.value = self.value || act[:default]
    end
  end

  private

  def set_token_name
    return unless self.key == 'validate_token'
    self.name = Token.find(self.value).name
  end

end
