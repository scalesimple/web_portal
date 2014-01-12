module RulesetsHelper

	def ruleset_status_icon(status)
		case status
		when 'ACTIVE'
			"<span class=\"label label-success\">Active</span>"
		when 'PENDING'
			"<span class=\"label label-warning\">Pending</span>"
		when 'UNASSIGNED'
			"<span class=\"label label-warning\">Unassigned</span>"	
		else
			"<span class=\"label label-important\">Error</span>"
		end
	end

end
