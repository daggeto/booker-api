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
      message: "#{service.name} #{booking_at}",
      payload: { state: AppStates::App::Main::RESERVATIONS }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
