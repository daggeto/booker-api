class Api::V1::Services::EventsController < Api::V1::BaseController
  def index
    render json: find_events, root: false
  end

  private

  def find_events
    Event
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
end
