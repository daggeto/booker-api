class Reservation::Approve
  include Interactor::Initializer

  initialize_with :reservation

  def run
    update_event

    reservation.touch(:approved_at)

    notify_user
  end

  private

  def update_event
    reservation.event.status = Event::Status::BOOKED

    reservation.event.save
  end

  def notify_user
    Notifications::ReservationConfirmed.for(reservation)
  end
end
