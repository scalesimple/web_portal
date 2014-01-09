module DnsUtil

	def self.lookup_arecs(hostname)
          return [hostname] if IPAddress.valid?(hostname)
	  return [] if $SKIP_DNS==true

	  ips = Array.new
	  begin
	     Net::DNS::Resolver.start(hostname).each_address { |a|
	        ips << a.to_s
	     }
	     ips.uniq
	   rescue => e
	      Rails.logger.info("DNS ERROR: #{e}")
	      false
	    end
	end

	def self.origin_aws_elb?(hostname)
	    return true if !hostname.match('/elb.amazonaws.com/').nil?
	    begin
	     Net::DNS::Resolver.start(hostname).each_cname { |c|
	      return true if c.match('/elb.amazonaws.com/')
	     }
	     false
	    rescue
	      false
	    end
	end

end
