class Notifications::ReservationUnconfirmed
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
      message: "Your booking at #{booking_at} are not confirmed",
      payload: { state: AppStates::App::MAIN }
    }
  end
end
