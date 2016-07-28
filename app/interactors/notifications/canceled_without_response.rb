class Notifications::CanceledWithoutResponse
  include Interactor::Initializer
  include Notifications::Sender

  initialize_with :event

  def receiver
    event.user
  end

  def notification_params
    {
      title: event.service.name,
      message: "Booking at #{booking_at} canceled due to no response"
    }
  end

  def booking_at
    event.start_at.strftime('%B %d %H:%M')
  end
end
