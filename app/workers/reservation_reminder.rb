class ReservationReminder
  include Sidekiq::Worker

  REMINDER_THRESHOLD = 2.hours

  def perform(*)
    find_events.find_each do |event|
      Event::Remind.for(event)
    end
  end

  private

  def find_events
    Event
      .where.not(user: nil)
      .where(status: Event::Status::BOOKED)
      .where(start_at: REMINDER_THRESHOLD.since)
  end
end
