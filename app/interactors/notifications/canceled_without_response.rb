class Notifications::CanceledWithoutResponse
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  MESSAGE = I18n.t('notification.cancel_without_response')

  initialize_with :reservation

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: "#{service.name} #{booking_at} ",
      message: MESSAGE,
      payload: { state: AppStates::App::MAIN }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
