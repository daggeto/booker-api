class Notifications::ConfirmEventBooking
  include Interactor::Initializer
  include Notifications::Sender

  initialize_with :client, :event

  private

  def notification_params
    {
      title: 'You have booking',
      message: "#{client.email} want to book you service at #{booking_at}",
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

  def receiver
    event.service.user
  end
end
