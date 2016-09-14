class Notifications::CanceledWithoutResponse
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  initialize_with :reservation

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: "#{service.name} #{booking_at} ",
      message: 'Canceled due to no response',
      payload: { state: AppStates::App::MAIN }
    }
  end

  def android_params
    { notId: reservation.id }
  end
end
