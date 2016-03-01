Rails.application.routes.draw do

  mount CalendarToQueue::Engine => "/calendar_to_queue"
end
