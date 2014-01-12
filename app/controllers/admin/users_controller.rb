class Admin::UsersController < ApplicationController
before_filter :authenticate_user!
before_filter :ensure_admin


def index
	if params[:status] == 'pending'
	  @users = User.where(:confirmed_at => nil).all
	 else
	  @users = User.all 
	 end
end

def confirm
	redirect_to admin_users_path, :notice => "Missing user_id param" and return unless params[:user_id]
	u = User.find(params[:user_id])
	u.send_confirmation_instructions
	redirect_to admin_users_path 
end

def disable
	redirect_to admin_users_path, :notice => "Missing user_id param" and return unless params[:user_id]
	u = User.find(params[:user_id])
	u.disable
	redirect_to admin_users_path 
end

def enable
	redirect_to admin_users_path, :notice => "Missing user_id param" and return unless params[:user_id]
	u = User.find(params[:user_id])
	u.enable
	redirect_to admin_users_path 
end


private 
 
  

end
