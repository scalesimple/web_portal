class TokensController < ApplicationController
 
  before_filter :authenticate_user!
  before_filter :load_account

  def index
    @tokens = @account.tokens.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tokens }
    end
  end


  # GET /tokens/new
  # GET /tokens/new.json
  def new
    @token = @account.tokens.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @token }
    end
  end


  # POST /tokens
  # POST /tokens.json
  def create
    @token = @account.tokens.new(params[:token])

    respond_to do |format|
      if @token.save
        format.html { redirect_to tokens_path, notice: 'Token was successfully created.' }
        format.json { render json: @token, status: :created, location: @token }
      else
        format.html { render action: "new" }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # DELETE /tokens/1
  # DELETE /tokens/1.json
  def destroy
    @token = @account.tokens.find(params[:id]).revoke
    @token.destroy

    respond_to do |format|
      format.html { redirect_to tokens_url }
      format.json { head :no_content }
    end
  end

private

  def load_account
    @account = current_account
  end

end
