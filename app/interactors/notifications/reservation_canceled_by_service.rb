class Notifications::ReservationCanceledByService
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  initialize_with :reservation

  def receiver
    reservation.user
  end

  def notification_params
    {
      title: 'Reservation canceled',
      message: "#{reservation.event.service.name} canceled your registration at #{booking_at}"
    }
  end
end
