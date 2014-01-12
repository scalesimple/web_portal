class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_writer :authorized_accounts_cache

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable, :confirmable, :token_authenticatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
   field :confirmed_at,         :type => Time
   field :confirmation_sent_at, :type => Time
   field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
   field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
   field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
   field :locked_at,       :type => Time

  ## Token authenticatable
   field :authentication_token, :type => String

   field :disabled, :type => Boolean, :default => false 
   field :must_change_password, :type => Boolean, :default => false

   field :global_admin , :type => Boolean, :default => false 

   before_create :skip_confirm_email  ## Comment out if you want registrations to go right away without approval 

   def authorized_accounts
    if self.global_admin?
      Account.all
    else
     @authorized_accounts_cache || @authorized_accounts_cache=Account.where("account_permissions.user_id"=>self.id)
    end
   end

   def global_admin?
     self.global_admin == true
   end
   
   def disabled?
    self.disabled == true 
   end

   def enabled?
    self.disabled == false
   end

   def disable
    self.update_attribute(:disabled,true)
   end

   def enable
    self.update_attribute(:disabled,false)
   end
   
   def self.create_from_email(email)
      user = User.new(:email => email, :password => "password")
      user.skip_confirmation!
      user.save!
      return user
   end

   def self.invite(email,account)
    u = User.new(:email => email, :password => Devise.friendly_token.first(12))
    u.must_change_password = true 
    u.save!
    u.send_confirmation_instructions
    u
   end

   def disable_reset_password
    self.update_attribute(:must_change_password,false)
   end 

   private

   def skip_confirm_email
    self.skip_confirmation_notification!
    Admin::UserMailer.new_signup(self.email).deliver
   end

   def self.find_first_by_auth_conditions(conditions)
    user = super
    if user && user.disabled?
       return nil
     end
     user
   end


end
