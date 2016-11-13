class Notifications::ReservationCanceledByClient
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  TITLE = I18n.t('notification.reservation_canceled')

  initialize_with :reservation

  private

  def receiver
    service.user
  end

  def sender
    reservation.user
  end

  def notification_params
    {
      title: TITLE,
      message: "#{reservation.user.email} #{booking_at}",
      payload:
        {
          state: AppStates::Service::CALENDAR,
          stateParams: {
            id: event.service.id,
            selectedDate: event.start_at
          }
        }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
