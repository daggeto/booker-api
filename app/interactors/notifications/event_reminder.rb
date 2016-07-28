class Notifications::EventReminder
  include Interactor::Initializer
  include Notifications::Sender

  initialize_with :event

  def receiver
    event.user
  end

  def notification_params
    {
      title: event.service.name,
      message: "You have reservation at #{booking_at}"
    }
  end

  def booking_at
    event.start_at.strftime('%B %d %H:%M')
  end
end
