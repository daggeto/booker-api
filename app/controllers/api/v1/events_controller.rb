class Api::V1::EventsController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

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

  private

  def events_params
    params.permit(:description, :service_id, :status, :start_at, :end_at)
  end

  def event
    @event ||= Event.find(params[:id] || params[:event_id])
  end
end