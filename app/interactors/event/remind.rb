class Event::Remind
  include Interactor::Initializer

  initialize_with :event

  def run
    Notifications::EventReminder.for(event)
  end
end
