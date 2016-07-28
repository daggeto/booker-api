class Event::Cancel
  include Interactor::Initializer

  initialize_with :event

  def run
    user = event.user

    event.status = Event::Status::FREE
    event.user = nil

    Notifications::EventCanceledByClient.for(user, event) if event.save
  end

end
