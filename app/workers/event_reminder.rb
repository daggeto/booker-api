class EventReminder
  include Sidekiq::Worker

  def perform(*)
    event = Event.find(12)
    puts event.inspect
    Notifications::EventReminder.for(event)
  end
end
