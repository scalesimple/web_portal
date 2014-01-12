class HostnamesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_account
  # GET /hostnames
  # GET /hostnames.json
  def index
    @filter = params[:filter] || 'all'
    @hostnames =  @account.hostnames.where("hostname_status.host" => { "$in" => filter(@filter)} ).desc(:created_at)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hostnames }
    end
  end

  # GET /hostnames/1
  # GET /hostnames/1.json
  def show
    @hostname = @account.hostnames.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hostname }
    end
  end

  # GET /hostnames/new
  # GET /hostnames/new.json
  def new
    @hostname = @account.hostnames.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hostname }
    end
  end

  # GET /hostnames/1/edit
  def edit
    @hostname = @account.hostnames.find(params[:id])
  end

  # POST /hostnames
  # POST /hostnames.json
  def create
    @hostname = @account.hostnames.new(params[:hostname])
    respond_to do |format|
      if @hostname.save
        format.html { redirect_to hostname_success_url(@hostname.id), notice: 'Hostname was successfully created.' }
        format.json { render json: @hostname, status: :created, location: @hostname }
      else
        format.html { render action: "new", :notice=>@hostname.errors.full_messages.join(", ") }
        format.json { render json: @hostname.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hostnames/1
  # PUT /hostnames/1.json
  def update
    @hostname = @account.hostnames.find(params[:id])

    respond_to do |format|
      if @hostname.update_attributes(params[:hostname])
        format.html { redirect_to hostnames_url, notice: 'Hostname was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", :notice=>@hostname.errors.full_messages.join(", ")  }
        format.json { render json: @hostname.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hostnames/1
  # DELETE /hostnames/1.json
  def destroy
    @hostname = @account.hostnames.find(params[:id])
    @hostname.destroy

    respond_to do |format|
      unless @hostname.errors.blank?
        flash[:notice]=@hostname.errors.full_messages.join(",")
      end
      format.html { redirect_to hostnames_url }
      format.json { head :no_content }
    end
  end

  def success
    @hostname = @account.hostnames.find(params[:hostname_id])
  end

private

  def filter(f)
    f.downcase == 'all' ? ['ACTIVE', 'PENDING'] : [ f.upcase ]
  end

  def load_account
    redirect_to new_account_path, :notice => "You need to create an account before you create any hostnames" and return if !current_account
    @account = current_account
  end

  def host_statuses(filter)

  end

end
