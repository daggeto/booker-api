class Event::Approve
  include Interactor::Initializer

  initialize_with :event

  def run
    event.status = Event::Status::BOOKED

    notify_user if event.save
  end

  def notify_user
    Notifications::EventBookingConfirmed.for(event)
  end
end
