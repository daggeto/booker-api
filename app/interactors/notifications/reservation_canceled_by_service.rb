class Notifications::ReservationCanceledByService
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  initialize_with :reservation

  def send?
    !reservation.event.past?
  end

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: 'Reservation canceled',
      message: "#{reservation.event.service.name}  at #{booking_at}",
      payload: { state: AppStates::App::MAIN }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
