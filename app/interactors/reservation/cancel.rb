class Reservation::Cancel
  include Interactor::Initializer

  initialize_with :reservation

  def run
    update_event

    reservation.destroy

    notify_user
  end

  def update_event
    reservation.event.status = Event::Status::FREE

    reservation.event.save
  end

  def notify_user
    Notifications::ReservationCanceledByClient.for(reservation)
  end
end
