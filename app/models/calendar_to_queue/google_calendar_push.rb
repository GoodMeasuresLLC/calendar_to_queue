module CalendarToQueue
  class GoogleCalendarPush < ActiveRecord::Base
    def process
      if self.token.blank?
        log("No Token", :warn)
      else
        send_to_queue if queue?
        save if persist?
      end

      unless queue?
        log("Token: #{self.token}")
      end
    end

    def payload
      attributes.slice('channel_id', 'message_number', 'resource_id', 'state', 'resource_uri', 'expiration', 'token')
    end

    def send_to_queue
      log("Sending to queue")
      CalendarToQueue::Queue.deliver(self)
    end
    private :send_to_queue

    # A-Z, a-z, 0-9, underscore(_), hyphen(-), and period (.). The
    # name must not start or end with a period, and it should not
    # have successive periods. The name is case sensitive and must
    # be unique among all attribute names for the message. The name
    # can be up to 256 characters long. The name cannot start with
    # "AWS." or "Amazon." (or any variations in casing) because
    # these prefixes are reserved for use by Amazon Web Services.
    def queue_name
      match_data = (token_hash['queue']||'').match(/^((?!(aws|amazon|\.))[a-z,0-9,_,\-,\.]{1,256})$/i)
      match_data[0] if match_data
    end

    def queue?
      queue_name.present?
    end
    private :queue?

    def persist?
      (token_hash['persist'] || '').match(/^(yes|true|1)$/i)
    end
    private :persist?

    def token_hash
      @token_hash ||= (token ||'').split('&').map {|x| x.split("=") }.to_h
    end

    def log(msg, level=:info)
      CalendarToQueue.logger.send(level, "Google Calendar Push: ChannelId: #{self.channel_id}, MessageNumber: #{self.message_number}, ResourceId: #{self.resource_id}, State: #{self.state} - #{msg}")
    end
    private :log

  end

end
