class Notifications::ReservationConfirmed
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  initialize_with :reservation

  private

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: event.service.name,
      message: "Booking confirmed. You are welcome at #{booking_at}",
      payload: { state: AppStates::App::Main::RESERVATIONS }
    }
  end
end
