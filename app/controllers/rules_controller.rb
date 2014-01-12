class RulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_account
  before_filter :load_ruleset
  before_filter :load_tokens
  before_filter :validate_not_active, :except => [:index, :show]
  # GET /rules
  # GET /rules.json
  def index
    @rules = @ruleset.rules.asc(:sort_index).asc(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rules }
    end
  end

 

  # GET /rules/1
  # GET /rules/1.json
  def show
    @rule = @ruleset.rules.find(params[:id])
    redirect_to edit_ruleset_rule_path(@ruleset,@rule) and return 


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/new
  # GET /rules/new.json
  def new
    @rule = @ruleset.rules.new(:match=>"ALL")
    @rule.make_default_conditions if @rule.conditions.blank?
    @rule.make_default_rule_actions if @rule.rule_actions.blank?


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/1/edit
  def edit
    @rule = @ruleset.rules.find(params[:id])
    @rule.make_default_conditions if @rule.conditions.blank?
    @rule.make_default_rule_actions if @rule.rule_actions.blank?
  end

  # POST /rules
  # POST /rules.json
  def create

    @rule = @ruleset.rules.new(params[:rule])

    @rule.set_conditions(params[:conditions])
    @rule.set_rule_actions(params[:rule_actions])

    respond_to do |format|
      if @rule.save
        format.html { redirect_to ruleset_rules_path(@ruleset), notice: 'Rule was successfully created.' }
        format.json { render json: @rule, status: :created, location: @rule }
      else
        flash[:notice]=@rule.errors.full_messages.join(", ")
        format.html { render action: "new", notice: @rule.errors.full_messages.join(", ") }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rules/1
  # PUT /rules/1.json
  def update

    @rule = @ruleset.rules.find(params[:id])
    @rule.set_conditions(params[:conditions])
    @rule.set_rule_actions(params[:rule_actions])
    
    @rule.match = params[:rule][:match]
    @rule.name = params[:rule][:name]
    @rule.global = params[:rule][:global]
    
    respond_to do |format|
      if @rule.save
        format.html { redirect_to ruleset_rules_path(@ruleset), notice: 'Rule was successfully updated.' }
        format.json { head :no_content }
      else
        flash[:notice]=@rule.errors.full_messages.join(", ")
        format.html { render action: "edit" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule =  @ruleset.rules.find(params[:id])
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to ruleset_rules_url(@ruleset) }
      format.json { head :no_content }
    end
  end

  def load_account
    @account = current_account
  end

  def load_tokens
    @tokens = @account.tokens
  end

  def load_ruleset
    @ruleset = @account.rulesets.find(params[:ruleset_id])
  end

  def validate_not_active
    redirect_to rulesets_path, notice: "Can not modify an active ruleset" and return if @ruleset.active?
  end
  
end
