class Notifications::EventBookingConfirmed
  include Interactor::Initializer
  include Notifications::Sender

  initialize_with :event

  private

  def receiver
    event.user
  end

  def notification_params
    {
      title: event.service.name,
      message: "Booking confirmed. You are welcome at #{booking_at}",
      payload: {
        state: 'service.calendar',
        stateParams: {
          id: event.service.id,
          selectedDate: event.start_at
        }
      }
    }
  end

  def booking_at
    event.start_at.strftime('%B %d %H:%M')
  end
end
