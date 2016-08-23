class Api::V1::EventsController < Api::V1::BaseController
  before_action :check_service_owner, only: [:create]
  before_action :check_event_owner, only: [:update, :destroy]

  def create
    result = Event::Validate.for(current_user, events_params)

    return render_conflict(message: result[:message]) unless result[:valid]

    Event::Create.for(events_params)

    render_success(message: result[:message])
  end

  def show
    render json: event
  end

  def update
    render json: { success: Event::Update.for(event, events_params) }
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
