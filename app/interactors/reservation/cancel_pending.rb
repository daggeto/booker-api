class Reservation::CancelPending
  include Interactor::Initializer

  initialize_with :reservation

  def run
    update_event

    notify_user

    reservation.destroy
  end

  def update_event
    reservation.event.status = Event::Status::FREE

    reservation.event.save
  end

  def notify_user
    Notifications::CanceledWithoutResponse.for(reservation)
  end
end
