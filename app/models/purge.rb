class Purge
  include Mongoid::Document
  include Mongoid::Timestamps

  field :hostname, type: String
  field :path, type: String
  field :account_id, type: String

  belongs_to :account, :index=>true

  validates :hostname, :presence=>true
  
  before_create :validate_hostname
  after_create :send_purge


private

  def validate_hostname
  	if !self.account.hostnames.map {|h| h.name }.include?(self.hostname)
  		errors.add(:base, "Sorry you entered an invalid URL")
  		return false
  	end
  	true
  end

  def send_purge
  	msg = { :action => "generate_ban", :payload => { :hostname => self.hostname, :path => self.path } }.to_json
    MqLib.publish(msg,'jobs.vcl')
  end


end
