require "calendar_to_queue/engine"
require_relative 'calendar_to_queue/configuration'
require_relative 'calendar_to_queue/access_control/admin_authentication'
require_relative 'calendar_to_queue/access_control/admin_authorization'

module CalendarToQueue
  class << self

    # Modify CalendarToQueue configuration
    # Example:
    #   CalendarToQueue.configure do |config|
    #   end
    def configure
      yield configuration
    end

    # Accessor for ComfortableMexicanSofa::Configuration
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

    def logger=(new_logger)
      @logger = new_logger
    end

    def logger
      @logger ||= Rails.logger
    end

  end
end
