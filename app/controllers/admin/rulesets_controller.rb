class Admin::RulesetsController < ApplicationController
 before_filter :authenticate_user!
 before_filter :ensure_admin

  def index
  	@rulesets = Ruleset.templates
  	render 'rulesets/index'
  end

  def disable
  	@ruleset = Ruleset.find(params[:ruleset_id]).first
  	@ruleset.update_attribute(:locked,false)
  	redirect_to admin_rulesets_path
  end

end
