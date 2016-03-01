module CalendarToQueue::AccessControl
  module AdminAuthentication
    # Set username and password in config/initializers/calendar_2_queue.rb
    # Like this:
    #   CalendarToQueue::AccessControl::AdminAuthentication = 'myname'
    #   CalendarToQueue::AccessControl::AdminAuthentication = 'mypassword'

    mattr_accessor  :username,
                    :password

    # Simple http_auth. When implementing some other form of authentication
    # this method should return +true+ if everything is great, or redirect user
    # to some other page, thus denying access to cms admin section.
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        self.username == username && self.password == password
      end
    end
  end
end
