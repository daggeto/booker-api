class Notifications::EventCanceledByClient
  include Interactor::Initializer
  include Notifications::Sender

  initialize_with :user, :event

  private

  def receiver
    event.service.user
  end

  def notification_params
    {
      title: 'Event canceled',
      message: "#{user.email} canceled registration at #{booking_at}"
    }
  end

  def booking_at
    event.start_at.strftime('%B %d %H:%M')
  end
end
