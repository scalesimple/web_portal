module ReportsHelper

	def report_nav_button(report,param)
		if param == report || (report == 'daily' && param.nil?)
			"btn btn-large disabled"
		else
			"btn btn-large btn-secondary"
		end
	end

	def report_nav_link(report,param)
		if param == report || (report == 'daily' && param.nil?)
			"#"
		else
			"/reports?report_type=" + report
		end
	end

    def year_dropdown
    	"<select name='year'><option value='2013' selected>2013</option><option value='2012'>2012</option></select>"
    end

	def month_dropdown(month)
		months = ['January','February','March','April','May','June','July','August','September','October','November','December']

		# year = Time.now.year
		#thismonth = Time.now.month
		# count = 0 
		dropdown = "<select name='month' onchange=\"insertParam('month',this.value);\">"
  #       (month-1).downto(0).each { |m| 
  #          dropdown += "<option value='" + m+1 + '">' + months[m] + '</option>'
  #       }
        0.upto(11).each { |m| 
          selected = (month.to_i == m+1) ? 'selected' : ' '
          dropdown += "<option value='#{(m+1).to_s}' " +  selected + " >#{months[m]}</option>"
        }
        dropdown += "</select>"
        dropdown
	end

    def hostname_dropdown(hostname,hostnames)
    	dropdown = "<select name='hostname' onchange=\"insertParam('hostname',this.value);\">"
    	hostnames.each { |h| 
    		selected = (hostname == h) ? 'selected' : ' ' 
    		dropdown += "<option value='#{h.id.to_s}' " + selected + " >#{h.name}</option>"
    	}
    	dropdown += "</select>"
    	dropdown
    end

end
