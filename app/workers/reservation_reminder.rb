class ReservationReminder
  include Sidekiq::Worker

  REMINDERS = [2.hours, 30.minutes]

  def perform(*)
    REMINDERS.each do |time|
      remind(time)
    end
  end

  private

  def remind(time)
    reservations(time).find_each do |reservation|
      Reservation::Remind.for(reservation)
    end
  end

  def reservations(time)
    Reservation
      .joins(:event)
      .where(events: { status: Event::Status::BOOKED })
      .where(events: { start_at: time.since.beginning_of_minute })
  end
end
