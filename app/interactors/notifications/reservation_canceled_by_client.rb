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
      title: 'Reservation canceled',
      message: "#{reservation.user.email} at #{booking_at}",
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
end
