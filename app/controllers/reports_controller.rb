class ReportsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :load_account 
  before_filter :fetch_params

def index
	@hits = {}
	@misses = {}

	case @report_type

		when 'monthly'

			@entries = MonthlyReport.fetch(@hostname.name,@year,@month)
			@hits = MonthlyReport.get_hits(@entries,@year,@month)
			@bytes = MonthlyReport.get_bytes(@entries,@year,@month)
			@total_bytes = @bytes.values.inject(0){|sum,x| sum+x} / 1000000000
			@hitrate_avg = (@hits.values.inject(0) { |sum,x| sum+x }) / @hits.keys.size
			render 'monthly'

		else
			@entry = DailyReport.fetch(@hostname.name,@year,@month,@day)
			render 'daily'
	end

end


private

  def load_account
    redirect_to new_account_path, :notice => "You need to create an account before you can view any reports" and return if !current_account
    @account = current_account
    @hostnames = @account.hostnames
    redirect_to new_hostname_path, :notice => "Please create a hostname before viewing any reports" and return if @hostnames.empty? 
  end

  def fetch_params
  	  @year = params[:year] || Time.now.year 
      @month = params[:month] || Time.now.month
      @day = params[:day] || Time.now.day 
      @hostname = params[:hostname] ? @account.hostnames.find(params[:hostname]) : @hostnames.first 
      @report_type = params[:report_type] || "daily"
  end

end
