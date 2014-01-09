class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :company_name, type: String
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :postal_code, type: String
  field :primary_contact, type: String
  field :primary_contact_email, type: String
  field :primary_phone, type: String
  field :secondary_phone, type: String
  field :max_hostnames, type: Integer, :default=>3

  index :name=>1
  index "account_permissions.user_id"=>1
  index "account_permissions.title"=>1
  
  belongs_to :user, :index=>true
  has_many :hostnames
  has_many :purges
  has_many :rulesets, :dependent=>:destroy
  has_many :tokens

  embeds_many :account_permissions

  validates :user_id, :presence=>true
  validates :name, :presence=>true
  validates :primary_contact, :presence=>true
  validates :primary_contact_email, :presence=>true
  validates :primary_phone, :presence=>true

  before_create :make_admin
  #after_create :make_default_rulesets

  def unassigned_rulesets
    self.rulesets.where(:status => $RULESET_STATUS[:unassigned])
  end

  def valid_rulesets
    self.rulesets.where(:status.ne => $RULESET_STATUS[:invalid])
  end

  def make_admin
    self.account_permissions << AccountPermission.new(:user=>self.user, :title=>"Admin")
  end

  def make_default_rulesets
    Ruleset.make_default_rulesets(self)
  end
end
