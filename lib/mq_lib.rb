module MqLib

    def self.client
    	unless @client
    		c = Bunny.new("amqp://#{$RABBIT_USER}:#{$RABBIT_PASSWORD}@#{$RABBIT_HOSTNAME}")
    		c.start
    		@client = c
    	end
    	@client
    end

	def self.exchange
  		@exchange ||= self.client.exchange($RABBIT_EXCHANGE, :durable => true )
	end

	def self.publish(msg,key = $RABBIT_DEFAULT_KEY)
		exchange.publish(msg, :key => key)
	end

end