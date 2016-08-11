class Notifications::CanceledWithoutResponse
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
      message: "Booking at #{booking_at} canceled due to no response",
      payload: { state: AppStates::App::MAIN }
    }
  end
end
