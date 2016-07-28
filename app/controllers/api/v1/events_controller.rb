class Api::V1::EventsController < Api::V1::BaseController
  before_action :check_service_owner, only: [:create]
  before_action :check_event_owner, only: [:update, :destroy, :approve, :disapprove]
  before_action :check_event_booker, only: [:cancel]

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

  def book
    code = Event::ValidateBooking.for(event, current_user)

    Event::Book.for(event, current_user) if code == 0

    render json: { response_code: code, service: event.service.to_dto }
  end

  def approve
    render json: { success: Event::Approve.for(event), event: event.reload }
  end

  def disapprove
    render json: { success: Event::Disapprove.for(event), event: event.reload}
  end

  def cancel
    render json: { success: Event::Cancel.for(event) }
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
