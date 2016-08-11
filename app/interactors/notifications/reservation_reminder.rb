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
      title: service.name,
      message: "You have reservation at #{booking_at}",
      payload: { state: AppStates::App::Main::RESERVATIONS }
    }
  end
end
