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
      title: 'Booking confirmed',
      message: "#{event.service.name} waiting you at #{booking_at}",
      payload: { state: AppStates::App::Main::RESERVATIONS }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
