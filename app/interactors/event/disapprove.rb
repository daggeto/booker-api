class Event::Disapprove
  include Interactor::Initializer

  initialize_with :event

  def run
    notify_user

    event.status = Event::Status::FREE
    event.user = nil

    event.save
  end

  def notify_user
    Notifications::EventBookingUnconfirmed.for(event)
  end
end
