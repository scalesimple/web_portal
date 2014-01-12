class RegistrationsController < Devise::RegistrationsController

 def update
 	if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
 	@user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      @user.disable_reset_password
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end 
 end

 private 

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

end
