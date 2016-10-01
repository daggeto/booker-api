class Reservation::Validate
  include Interactor::Initializer
  include Validator

  SUCCESS = I18n.t('reservation.success')
  CANT_BOOK = I18n.t('reservation.cant_book')
  RESERVED_OVERLAPS = I18n.t('reservation.reserved_overlaps')
  OWNED_OVERLAPS = I18n.t('reservation.owned_overlaps')

  initialize_with :event, :user

  def run
    return fail_with CANT_BOOK unless event.free?

    return fail_with RESERVED_OVERLAPS if find_user_reservations.any?

    return fail_with OWNED_OVERLAPS if find_service_events.any?

    success_with SUCCESS
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
