class Reservation::Validate
  include Interactor::Initializer

  SUCCESS = 'Event booked. You will get answer in 1 hour!'
  CANT_BOOK = "Event can't be booked."
  RESERVED_OVERLAPS = 'It overlaps with your current reservations.'
  OWNED_OVERLAPS = 'It overlaps with your service events.'

  initialize_with :event, :user

  def run
    return { valid: false, message: CANT_BOOK} unless event.free?

    return { valid: false, message: RESERVED_OVERLAPS } if find_user_reservations.any?

    return { valid: false, message: OWNED_OVERLAPS } if find_service_events.any?

    { valid: true, message: SUCCESS }
  end

  private

  def find_user_reservations
    Event
      .in_range(event.start_at, event.end_at)
      .joins(:reservation)
      .where(reservations: { user_id: user.id })
  end

  def find_service_events
    return [] unless user.service

    user.service.events.in_range(event.start_at, event.end_at)
  end
end
