module HostnamesHelper

	def hostname_status_icon(status)
		case status
		when 'ACTIVE'
			"<span class=\"label label-success\">Active</span>"
		when 'PENDING'
			"<span class=\"label label-warning\">Pending</span>"
		else
			"<span class=\"label label-important\">Error</span>"
		end
	end

	def hostname_filters(filter)
		all = filter == 'all' ? 'All' : link_to('All', hostnames_path(:filter => 'all'))
		pending = filter == 'pending' ? 'Pending' : link_to('Pending', hostnames_path(:filter => 'pending'))
		active = filter == 'active' ? 'Active' : link_to('Active', hostnames_path(:filter => 'active'))

        all + ' | ' + pending + ' | ' + active
	end

end
