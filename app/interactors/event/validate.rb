class Event::Validate
  include Interactor::Initializer
  include Validator

  SUCCESS = I18n.t('event.created')
  OVERLAPS_WITH_SERVICE = I18n.t('event.overlaps_with_service')
  OVERLAPS_WITH_RESERVATION = I18n.t('event.overlaps_with_reservation')

  initialize_with :user, :params

  def run
    return fail_with OVERLAPS_WITH_SERVICE if find_service_event.any?

    return fail_with OVERLAPS_WITH_RESERVATION if find_user_reservations.any?

    success_with SUCCESS
  end

  private

  def find_service_event
    user.service.events.in_range(start_at, end_at).where.not(id: params[:excluded_id])
  end

  def find_user_reservations
    Event
      .in_range(start_at, end_at)
      .joins(:reservation)
      .where(reservations: { user_id: user.id })
  end

  def start_at
    DateTime.parse(params[:start_at])
  end

  def end_at
    DateTime.parse(params[:end_at])
  end
end
