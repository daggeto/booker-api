class Event::Book
  attr_reader :event, :user

  def self.for(event, user)
    new(event, user).run
  end

  def initialize(event, user)
    @event = event
    @user = user
  end

  def run
    event.status = Event::Status::PENDING

    event.user = user

    notify_provider if event.save
  end

  def notify_provider
    Notifications::ConfirmEventBooking.for(user, event)
  end
end
