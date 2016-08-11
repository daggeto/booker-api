class Notifications::ConfirmReservation
  include Interactor::Initializer
  include Notifications::Sender
  include ReservationHelper

  initialize_with :reservation

  private

  def notification_params
    {
      title: 'You have booking',
      message: "#{reservation.user.email} want to book you service at #{booking_at}",
      payload: {
        state: AppStates::Service::CALENDAR,
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
end
