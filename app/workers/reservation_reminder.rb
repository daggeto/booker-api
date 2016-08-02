class ReservationReminder
  include Sidekiq::Worker

  REMINDER_THRESHOLD = 2.hours

  def perform(*)
    find_reservations.find_each do |reservation|
      Reservation::Remind.for(reservation)
    end
  end

  private

  def find_reservations
    Reservation
      .joins(:event)
      .where(events: { status: Event::Status::BOOKED })
      .where(events: { start_at: REMINDER_THRESHOLD.since })
  end
end
