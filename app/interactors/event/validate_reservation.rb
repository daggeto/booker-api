class Event::ValidateReservation
  attr_reader :event, :user

  def self.for(event, user)
    new(event, user).run
  end

  def initialize(event, user)
    @event = event
    @user = user
  end

  def run
    return Event::BookStatus::CANT_BOOK unless event.free?

    return Event::BookStatus::USER_EVENTS_OVERLAP if user_overlap_events.any?

    return Event::BookStatus::SERVICE_EVENTS_OVERLAP if find_service_overlap_events.any?

    Event::BookStatus::SUCCESS
  end

  private

  def user_overlap_events
    @user_overlap_events ||= find_user_overlap_events
  end

  def find_user_overlap_events
    user.events.in_range(event.start_at, event.end_at)
  end

  def find_service_overlap_events
    return [] unless user.service

    user.service.events.in_range(event.start_at, event.end_at)
  end
end
