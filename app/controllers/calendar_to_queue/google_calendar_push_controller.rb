require_dependency "calendar_to_queue/application_controller"

module CalendarToQueue

  #
  # Reciever for push notifications from watched resources in Google Calendar
  #
  class GoogleCalendarPushController < ApplicationController
    def create
      GoogleCalendarPush.new(create_params).process
      head :ok
    end

    # https://developers.google.com/google-apps/calendar/v3/push#understanding-the-notification-message-format
    def create_params
      {
        channel_id:     request.headers['X-Goog-Channel-ID'],
        message_number: request.headers['X-Goog-Message-Number'],
        resource_id:    request.headers['X-Goog-Resource-ID'],
        state:          request.headers['X-Goog-Resource-State'],
        resource_uri:   request.headers['X-Goog-Resource-URI'],
        expiration:     request.headers['X-Goog-Channel-Expiration'],
        token:          request.headers['X-Goog-Channel-Token']
      }
    end
    private :create_params
  end
end
