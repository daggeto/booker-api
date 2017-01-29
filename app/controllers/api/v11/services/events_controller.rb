class Api::V11::Services::EventsController < Api::BaseController
  before_action :check_service_owner, only: [:index]

  def index
    render json: {
      events: serialize_all(find_events, EventSerializer),
      available_days: available_days(start_at.beginning_of_week)
    }
  end

  def future
    render json: {
      events: serialize_all(future_events, EventSerializer),
      available_days: available_days(future_available_date)
    }
  end

  private

  def find_events
    Event
      .where(events_query_params)
      .where('start_at >= ? AND start_at <= ?', start_at, end_at)
      .order(:start_at)
  end

  def future_events
    Event
      .after(Event::VISIBLE_FROM_TIME.since)
      .where(events_query_params)
      .where('start_at >= ? AND start_at <= ?', start_at, end_at)
      .where(status: Event::Status::VISIBLE)
      .order(:start_at)
  end



  def future_available_date
    from_date = start_at.beginning_of_week

    return Event::VISIBLE_FROM_TIME.since if Event::VISIBLE_FROM_TIME.since > from_date

    from_date
  end

  def available_days(from_date)
    Event::AvailableDays.for(service, from_date)
  end

  def events_query_params
    params.permit(:service_id)
  end

  def start_at
    DateTime.parse(params[:start_at])
  end

  def end_at
    start_at + 1.day
  end

  def service
    @service ||= Service.find(params[:service_id])
  end
end
