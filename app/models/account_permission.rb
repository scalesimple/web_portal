class AccountPermission
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :email, :current_user

  field :title, type: String
  field :hostnames, :type=> Hash, :default=>{}

  embedded_in :account

  belongs_to :user

  validates :user_id, :presence=>true
  validates :title, :presence=>true

 before_validation :validate_user
 before_destroy :validate_permission_to_destroy

 def validate_user
    if self.email && self.user.blank?
        u = User.where(:email=>self.email).first || User.invite(self.email,self.account)
        InviteMailer.grant_account_permission(u,account).deliver
        self.user = u if u.persisted?
    end
 end

 def validate_permission_to_destroy
    unless removable_by?(self.current_user)
        self.errors.add(:base, "Creator cannot be deleted, and current user cannot remove themselves.")
        return false
    end
    true
 end

  # Current user cannot remove their own permission
  # Creator of account cannot be removed
  def removable_by?(current_user)
    !((self.user_id==self.account.user_id)  || (self.user_id==current_user.id))
  end
end
