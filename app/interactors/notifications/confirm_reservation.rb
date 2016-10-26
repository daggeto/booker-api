class Notifications::ConfirmReservation
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  TITLE = I18n.t('notification.confirm_reservation')

  initialize_with :reservation

  private

  def notification_params
    {
      title: TITLE,
      message: "#{reservation.user.email} #{booking_at}",
      payload: {
        state: AppStates::Service::RESERVATIONS,
        stateParams: {
          id: event.service.id,
          selectedDate: event.start_at
        }
      }
    }
  end

  def receiver
    service.user
  end

  def android_params
    { notId: reservation.id }
  end
end
