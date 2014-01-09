class HostnameStatus
  include Mongoid::Document

  cattr_writer :statuses
  @@host_statuses = %w(ACTIVE READY PENDING PENDING_REMOVAL INACTIVE)  ## Are they pointing their host correctly?
  @@origin_statuses = %w(ACTIVE PENDING ERROR)  ## This is just whether the origin is healthy
  @@cname_statuses = %w(ACTIVE PENDING ERROR)   ## This is the cname to edge.scalesimple, did the entry create ?

  field :host, type: String, :default=>"PENDING"
  field :origin, type: String, :default=>"PENDING"
  field :cname, type: String, :default=>"PENDING"

  embedded_in :hostname

  before_save :set_host_status


  def set_host_status
    return true
    if self.origin_changed? || self.cname_changed?
        if ([self.origin,self.cname]-["RESOLVED","RESOLVED"])==[] && self.host=="PENDING"
            self.host="READY"
        elsif !([self.origin,self.cname]-["RESOLVED","RESOLVED"]).empty?
            self.host="PENDING"
        end
    end
  end
end