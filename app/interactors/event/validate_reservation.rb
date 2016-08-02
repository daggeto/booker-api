class Event::ValidateReservation
  include Interactor::Initializer

  initialize_with :event, :user

  def run
    return Reservation::Status::CANT_BOOK unless event.free?

    return Reservation::Status::RESERVED_OVERLAPS if find_user_reservations.any?

    return Reservation::Status::OWNED_OVERLAPS if find_service_events.any?

    Reservation::Status::SUCCESS
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
