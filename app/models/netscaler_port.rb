class NetscalerPort
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ip_address, type: String 
  field :port, type: Integer, :default=>1025

end
