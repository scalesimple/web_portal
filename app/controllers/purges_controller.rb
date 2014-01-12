class PurgesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_account

  # GET /purges
  # GET /purges.json
  def index
    @purges = @account.purges.desc(:created_at).limit(100)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purges }
    end
  end

 

  # GET /purges/new
  # GET /purges/new.json
  def new
    @purge = @account.purges.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purge }
    end
  end

 

  # POST /purges
  # POST /purges.json
  def create
    @purge = @account.purges.new(params[:purge])
    @purge.account_id = @account.id

    respond_to do |format|
      if @purge.save
        format.html { redirect_to purges_path, notice: 'Purge was successfully created.' }
        format.json { render json: @purge, status: :created, location: @purge }
      else
        format.html { render action: "new" }
        format.json { render json: @purge.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def load_account
    @account = current_account
  end


end
