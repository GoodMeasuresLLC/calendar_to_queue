CalendarToQueue::Engine.routes.draw do
  resources :google_calendar_push, only: [:create]
end
