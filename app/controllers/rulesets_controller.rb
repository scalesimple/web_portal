class RulesetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_account
  before_filter :load_system_rulesets, :only => [:new, :edit, :create]


  # GET /rulesets
  # GET /rulesets.json

  def clone
    @ruleset = @account.rulesets.find(params[:ruleset_id])
    @ruleset2 = @ruleset.clone_ruleset
    if @ruleset2.save
     redirect_to rulesets_path, notice: "Ruleset cloned successfully"
    else
     redirect_to rulesets_path, notice: @ruleset.errors.full_messages.join(", ")
    end
  end

   def reorder
     return unless params["order"]
     @ruleset = @account.rulesets.find(params[:ruleset_id])
     @ruleset.reorder(params["order"])
     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: "success".to_json }
     end
  end

  def index
    @rulesets = @account.rulesets.desc(:default).asc(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rulesets }
    end
  end

  # GET /rulesets/1
  # GET /rulesets/1.json
  def show
    @ruleset = @account.rulesets.find(params[:id])
    @rules = @ruleset.rules.asc(:sort_index)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ruleset }
    end
  end

  # GET /rulesets/new
  # GET /rulesets/new.json
  def new
    @ruleset = @account.rulesets.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ruleset }
    end
  end

  # GET /rulesets/1/edit
  def edit
    @ruleset = @account.rulesets.find(params[:id]) 
    ensure_not_active
  end

  # POST /rulesets
  # POST /rulesets.json
  def create
    @ruleset = @account.rulesets.new(params[:ruleset])
    if !params[:ruleset]["ruleset_template_id"].blank?
       @template = Ruleset.where(:id => params[:ruleset]["ruleset_template_id"]).where(:locked => true).first 
       @ruleset.rules = @template.rules 
    end

    respond_to do |format|
      if @ruleset.save
        format.html { redirect_to ruleset_path(@ruleset), notice: 'Ruleset was successfully created.' }
        format.json { render json: @ruleset, status: :created, location: @ruleset }
      else
        format.html { render action: "new", :notice=>@ruleset.errors.full_messages.join(", ") }
        format.json { render json: @ruleset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rulesets/1
  # PUT /rulesets/1.json
  def update
    @ruleset = @account.rulesets.find(params[:id])
    ensure_not_active

    respond_to do |format|
      if @ruleset.update_attributes(params[:ruleset])
        format.html { redirect_to ruleset_path(@ruleset), notice: 'Ruleset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", :notice=>@ruleset.errors.full_messages.join(", ") }
        format.json { render json: @ruleset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rulesets/1
  # DELETE /rulesets/1.json
  def destroy
    @ruleset = @account.rulesets.find(params[:id])
    ensure_not_active
    @ruleset.destroy
    error = @ruleset.errors.full_messages.join(" ")
    Rails.logger.info("Logging error " + error)
    respond_to do |format|
      format.html { redirect_to rulesets_url, :alert => error }
      format.json { head :no_content }
    end
  end

  def load_account
    @account = current_account
  end

  private

  def ensure_not_active
     redirect_to rulesets_path, notice: "Sorry you can not edit an active ruleset" and return if @ruleset.active?
  end

  def load_system_rulesets
    @system_rulesets = Ruleset.where(:locked => true).all
  end

end
