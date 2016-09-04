class Notifications::ReservationReminder
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  initialize_with :reservation

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: 'Reservation reminder',
      message: "#{service.name} at #{booking_at}",
      payload: { state: AppStates::App::Main::RESERVATIONS }
    }
  end
end
