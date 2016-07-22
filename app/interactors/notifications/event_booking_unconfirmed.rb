class EventBookingUnconfirmed
  include Interactor::Initializer
  include Notifications::Sender

  initialize_with :event

  private

  def receivers
    [event.user]
  end

  def notification_params
    {
      title: event.service.name,
      message: "Your booking at #{booking_at} are not confirmed"
    }
  end

  def booking_at
    event.start_at.strftime('%B %d %H:%M')
  end
end