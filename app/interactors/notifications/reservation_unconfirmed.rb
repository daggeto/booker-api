class Notifications::ReservationUnconfirmed
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  TITLE = I18n.t('notification.reservation_not_confirmed')

  initialize_with :reservation

  private

  def receiver
    reservation.user
  end

  def sender
    service
  end

  def notification_params
    {
      title: TITLE,
      message: "#{service.name} #{booking_at}",
      payload: { state: AppStates::App::MAIN }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
