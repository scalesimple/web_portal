class Token
  include Mongoid::Document
  include Mongoid::Timestamps

  field :secret, type: String
  field :location, type: String
  field :name, type: String

  index :name => 1

  belongs_to :account, :index => true 

  before_create :create_secret_key

  validates_inclusion_of :location, :in => %w( header cookie url), :message => "Valid token options are headers, cookie or URL"

  attr_protected :secret

private
   def create_secret_key
   	self.secret = SecureRandom.base64(32)
   end
   
end
