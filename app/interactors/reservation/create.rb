class Reservation::Create
  include Interactor::Initializer

  initialize_with :event, :user

  def run
    reservation
    update_event

    notify_provider
  end

  private

  def update_event
    event.status = Event::Status::PENDING

    event.save
  end

  def reservation
    @reservation ||= Reservation.create(event: event, user: user)
  end

  def notify_provider
    Notifications::ConfirmReservation.for(reservation)
  end
end
