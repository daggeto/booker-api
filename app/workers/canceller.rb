class Canceller
  include Sidekiq::Worker

  CANCEL_PERIOD = 1.hour

  def perform(*)
    pending_reservations.find_each do |reservation|
      Reservation::CancelPending.for(reservation)
    end
  end

  private

  def pending_reservations
    Reservation
      .joins(:event)
      .where('reservations.created_at < ?', CANCEL_PERIOD.ago)
      .where(events: { status: Event::Status::PENDING })
  end
end
