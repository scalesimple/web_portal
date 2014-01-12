class DailyReport < Report
  include Mongoid::Document
  store_in session: "stats", collection: "stats_daily"

  def self.fetch(hostname, year = Time.now.year, month = Time.now.month, day = Time.now.day)
  	DailyReport.where(:host => hostname, :year => year.to_s, :month => month.to_s, :day => day.to_s ).first
  end

end
