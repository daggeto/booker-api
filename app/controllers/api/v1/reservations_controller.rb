class Api::V1::ReservationsController < Api::V1::BaseController
  def create
    code = Event::ValidateBooking.for(event, current_user)

    Reservation::Create.for(event, current_user) if code == 0

    render json: { response_code: code, service: event.service.to_dto }
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end
end
