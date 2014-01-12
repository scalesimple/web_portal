class AccountPermissionsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @account = current_user.authorized_accounts.find(params[:account_id])
    @account_permission = @account.account_permissions.new(params[:account_permission])
    
    respond_to do |format|
     if @account_permission.save
        format.html { redirect_to account_path(@account, :anchor=>"t_tab_permissions"), notice: 'Permission was successfully added' }
        format.json { render json: @account_permission, status: :created, location: @account }
      else
        format.html { redirect_to account_path(@account, :anchor=>"t_tab_permissions"), notice: @account_permission.errors.full_messages.join(",") }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = current_user.authorized_accounts.find(params[:account_id])
    @account_permission = @account.account_permissions.find(params[:id])
    @account_permission.current_user=current_user
    respond_to do |format|
    if @account_permission.destroy
        format.html { redirect_to account_path(@account, :anchor=>"t_tab_permissions"), notice: 'Permission was successfully removed' }
        format.json { render json: @account_permission, status: :created, location: @account }
      else
        format.html { redirect_to account_path(@account, :anchor=>"t_tab_permissions"), notice: @account_permission.errors.full_messages.join(",") }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end
end