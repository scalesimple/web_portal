class MonthlyReport < Report
  include Mongoid::Document
  store_in session: "stats", collection: "stats_daily"

  def self.fetch(hostname, year = Time.now.year, month = Time.now.month)
  	MonthlyReport.where(:host => hostname, :year => year.to_s, :month => month.to_s).all
  end

  def self.get_hits(entries,year,month)
      hits = {}
  	  entries.each { |e|
	        	hits[e.day.to_i] = ( (e.measures["hits"].to_f / (e.measures["hits"].to_f + e.measures["misses"].to_f)) * 100 ).round
	  }
	  1.upto(days_in_month(month.to_i,year.to_i)).each { |e|
  	     hits[e] = 0 unless hits.has_key?(e)	
  	  }
  	  hits
  end

  def self.get_bytes(entries,year,month)
  	  bytes = {}
  	  entries.each { |e|
  	  	        Rails.logger.info("Logging bytes " + e.measures["bytes"].to_s	)
	        	bytes[e.day.to_i] = (e.measures["bytes"].to_i)
	  }
	  1.upto(days_in_month(month.to_i,year.to_i)).each { |e|
  	     bytes[e] = 0 unless bytes.has_key?(e)	
  	  }
  	  bytes
  end


  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def self.days_in_month(month, year = Time.now.year)
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end

end
