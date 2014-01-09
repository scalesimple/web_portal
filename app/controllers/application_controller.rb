class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :redirect_if_must_change_pass

  layout :layout_by_resource

  helper_method :current_account, :is_global_admin?

  def current_account
    return @current_account if @current_account
    return nil unless current_user.authorized_accounts.size > 0 
    if session[:current_account_id]
      @current_account = current_user.authorized_accounts.find(session[:current_account_id])
    else
      @current_account = current_user.authorized_accounts.first
    end
      @current_account
  end

  def current_account=(val)
    session[:current_account_id]= val ? val.id : nil
    @current_account=val
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

 private

  def edit_page
     params[:controller] == 'registrations' && (params[:action] == 'edit' || params[:action] == 'update')
  end

  def redirect_if_must_change_pass
    redirect_to edit_user_registration_path and return if !edit_page && current_user && current_user.must_change_password && current_user.must_change_password == true
  end

  def is_global_admin?
    current_user.email.in?($GLOBAL_ADMINS)
  end

  def ensure_admin
    redirect_to '/404.html' and return unless current_user.email.in?($GLOBAL_ADMINS)
  end


end
