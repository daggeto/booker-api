class Notifications::ReservationCanceledByClient
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  initialize_with :reservation

  private

  def receiver
    event.service.user
  end

  def notification_params
    {
      title: 'Event canceled',
      message: "#{reservation.user.email} canceled registration at #{booking_at}"
    }
  end
end
