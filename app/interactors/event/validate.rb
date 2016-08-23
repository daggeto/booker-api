class Event::Validate
  include Interactor::Initializer
  include Validator

  SUCCESS = 'Event created.'
  OVERLAPS_WITH_SERVICE = 'This date overlaps with your existing events.'
  OVERLAPS_WITH_RESERVATION = 'This date overlaps with your reservations.'

  initialize_with :user, :params

  def run
    return fail_with OVERLAPS_WITH_SERVICE if find_service_event.any?

    return fail_with OVERLAPS_WITH_RESERVATION if find_user_reservations.any?

    success_with SUCCESS
  end

  private

  def find_service_event
    user.service.events.in_range(start_at, end_at)
  end

  def find_user_reservations
    Event
      .in_range(start_at, end_at)
      .joins(:reservation)
      .where(reservations: { user_id: user.id })
  end

  def start_at
    params[:start_at]
  end

  def end_at
    params[:end_at]
  end
end
