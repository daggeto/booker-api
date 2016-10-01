class Notifications::ReservationConfirmed
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  TITLE = I18n.t('notification.reservation_confirmed.title')

  initialize_with :reservation

  private

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: TITLE,
      message: I18n.t(
          'notification.reservation_confirmed.message',
          service: event.service.name,
          time: booking_at
      ),
      payload: { state: AppStates::App::Main::RESERVATIONS }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
