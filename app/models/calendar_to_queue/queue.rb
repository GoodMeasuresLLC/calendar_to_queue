module CalendarToQueue
  class Queue < ActiveRecord::Base

    def self.deliver(push)
      unless push.queue_name.blank?
        queue = lookup(push.queue_name)
        queue.deliver(push)
      end
    end

    def deliver(push)
      begin
        CalendarToQueue::Queue.client.send_message({
          queue_url: url,
          message_body: JSON.generate(push.payload),
        })
      rescue Aws::SQS::Errors::ServiceError => e
        CalendarToQueue.logger.error("Error sending to queue #{self.name}, push: #{}AWS QUEUE: #{e.context}: #{e.code}")
      end
    end

    # Creates or finds
    def self.lookup(name)
      find_by_name(name) || create_queue(name)
    end

    def self.create_queue(name)
      create(name: name)
    end

    after_create do
      begin
        response = client.create_queue(queue_name: name)
        self.update_attributes(url: response.queue_url)
      rescue Aws::SQS::Errors::ServiceError => e
        CalendarToQueue.logger.error("Error creating AWS QUEUE: #{e.context}: #{e.code}")
      end
    end

    def client
      CalendarToQueue::Queue.client
    end
    private :client

    def self.client
      @@client ||= Aws::SQS::Client.new(
        region: 'us-east-1',
        access_key_id:     CalendarToQueue.config.aws_access_key_id,
        secret_access_key: CalendarToQueue.config.aws_secret_access_key
      )
    end
  end
end
