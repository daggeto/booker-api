class Api::V1::EventsController < Api::V1::BaseController
  before_action :check_service_owner, only: [:create]
  before_action :check_event_owner, only: [:update, :destroy]

  def create
    render json: { success: Event.create(events_params) }
  end

  def show
    render json: event
  end

  def update
    success = event.update_attributes(events_params)

    render json: { success: success }
  end

  def destroy
    render json: { success: Event::Delete.for(event) }
  end

  private

  def events_params
    params.permit(:description, :service_id, :status, :start_at, :end_at)
  end

  def event
    @event ||= Event.find(params[:id] || params[:event_id])
  end

  def service
    @service ||= Service.find(params[:service_id])
  end
end
