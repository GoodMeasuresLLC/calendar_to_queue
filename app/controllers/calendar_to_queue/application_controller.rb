module CalendarToQueue
  class ApplicationController < ActionController::Base
    # Authentication module must have `authenticate` method
    include CalendarToQueue.config.admin_auth.to_s.constantize

    # Authorization module must have `authorize` method
    include CalendarToQueue.config.admin_authorization.to_s.constantize
  end
end
