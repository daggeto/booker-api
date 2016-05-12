class Api::V1::EventsController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def index
    render json: find_events, root: false
  end

  def create
    render json: { success: Event.create(events_params) }
  end

  def show
    render json: Api::V1::EventSerializer.new(event), root: false
  end

  def update
    success = event.update_attributes(events_params)

    render json: { success: success }
  end

  def destroy
    render json: { success: Event.find(params[:id]).destroy }
  end

  private

  def find_events
    Event
      .where(service_id: events_params[:service_id])
      .where('start_at >= ? AND end_at <= ?', start_at, end_at)
      .order(:start_at)
  end

  def events_params
    params.permit(:description, :service_id, :status, :start_at, :end_at)
  end

  def start_at
    DateTime.parse(params[:start_at])
  end

  def end_at
    start_at + 1.day
  end

  def event
    @event ||= Event.find(params[:id])
  end
end