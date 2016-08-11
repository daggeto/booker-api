class Api::V1::Services::EventsController < Api::V1::BaseController
  before_action :check_service_owner, only: [:index]

  def index
    render json: find_events, root: false
  end

  def future
    render json: future_events
  end

  private

  def find_events
    Event
      .where(events_query_params)
      .where('start_at >= ? AND end_at <= ?', start_at, end_at)
      .order(:start_at)
  end

  def future_events
    Event
      .after(Time.zone.now)
      .where(events_query_params)
      .where('start_at >= ? AND end_at <= ?', start_at, end_at)
      .order(:start_at)
  end

  def events_query_params
    params.permit(:service_id, status: [])
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
