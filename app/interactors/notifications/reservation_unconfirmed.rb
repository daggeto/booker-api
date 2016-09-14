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
      title: 'Reservation not confirmed',
      message: "#{service.name} #{booking_at}",
      payload: { state: AppStates::App::MAIN }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
