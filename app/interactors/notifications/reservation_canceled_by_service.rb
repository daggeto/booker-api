class Notifications::ReservationCanceledByService
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  TITLE = I18n.t('notification.reservation_canceled')

  initialize_with :reservation

  def send?
    !reservation.event.past?
  end

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: TITLE,
      message: "#{reservation.event.service.name} #{booking_at}",
      payload: { state: AppStates::App::MAIN }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
