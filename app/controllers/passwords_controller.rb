class PasswordsController < Devise::PasswordsController

  def new 
   super
  end

  def create
    redirect_to new_user_session_path, :notice => "Sorry that account has not been confirmed yet" and return unless user_is_confirmed
    super
  end

private 
   def user_is_confirmed
     @user = User.where(:email => params[:user]["email"]).first
     !@user.nil? && @user.confirmed?
   end

end
