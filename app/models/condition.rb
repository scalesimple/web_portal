class Condition
  include Mongoid::Document

  #V=Value  #NV=NameValue #DV=DropdownValue
  cattr_accessor :conditionals, :operators
  @@conditionals = 
    {
      :request_url=>{:label=>"Request Url", :type=>"V", :advanced=>false, :help_text=>"Comma separated eg., /about, /home, etc.", :operators=>[["CONTAINS","CONTAINS"],["DOESNOTCONTAIN","DOES NOT CONTAIN"],["STARTSWITH","STARTS WITH"]]},
      :content_type=>{:label=>"Content Type", :type=>"V", :advanced=>false, :help_text=>"Comma separated eg., *.js, *.css, *.png, *.jpg, etc.", :operators=>[["MATCHES","MATCHES"],["DOESNOTMATCH","DOES NOT MATCH"]]},
      :client_ip=>{:label=>"Client IP", :type=>"V", :advanced=>true, :help_text=>"Comma Separated eg., 46.36.198.121, 46.36.198.0/24", :operators=>[["MATCHES","MATCHES"],["DOESNOTMATCH","DOES NOT MATCH"]]},
      :request_parameter=>{:label=>"Request Parameter", :type=>"NV", :advanced=>true, :help_text=>"Enter url parameter name and value", :operators=>[["MATCHES","MATCHES"],["DOESNOTMATCH","DOES NOT MATCH"], ["EQUALS","EQUALS"],["DOESNOTEQUAL","DOES NOT EQUAL"]]},
      :client_cookie=>{:label=>"Client Cookie", :type=>"NV", :advanced=>true, :help_text=>"Enter cookie name and value", :operators=>[["MATCHES","MATCHES"],["DOESNOTMATCH","DOES NOT MATCH"],["EQUALS","EQUALS"],["DOESNOTEQUAL","DOES NOT EQUAL"]]},
      :request_header=>{:label=>"Request Header", :type=>"NV", :advanced=>false, :help_text=>"Enter header name and value", :operators=>[["MATCHES","MATCHES"],["DOESNOTMATCH","DOES NOT MATCH"],["EQUALS","EQUALS"],["DOESNOTEQUAL","DOES NOT EQUAL"]]},
      :country=>{:label=>"Request Country", :type=>"DV", :advanced=>true, :help_text=>"Country where the request is coming from", :operators=>[["EQUALS","EQUALS"],["DOESNOTEQUAL","DOES NOT EQUAL"]]},
    }
  
  field :key, type: String
  field :operator, type: String
  field :name, type: String
  field :value, type: String

  embedded_in :rule

  def conditional
    Condition.conditionals[self.key.to_sym]
  end
  
  def valid_condition?
    !self.value.blank? && conditional[:type].in?('V','DV','NV') #&& !self.name.blank?
  end

  def vcl_condition
    {:key=>self.key.to_sym, :operator=>self.operator, :value=>self.value, :name=>self.name.blank? ? nil : self.name}
  end
  
  def to_text
    return nil unless self.valid_condition?
    cond = self.conditional
    if (cond[:type]=="V" || cond[:type] == "DV") && !self.value.blank?
      "#{cond[:label]} #{self.operator} [#{value}]"
    elsif (conditional[:type]=="NV") && !self.value.blank? && !self.name.blank?
      "#{cond[:label]} [#{name}] #{self.operator} [#{value}]"
    else
      nil
    end
  end

end

