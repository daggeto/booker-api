class Api::V1::ReservationsController < Api::V1::BaseController
  before_action :check_event_owner, only: [:approve, :disapprove]
  before_action :check_reservation_owner, only: [:cancel]

  def create
    code = Event::ValidateBooking.for(event, current_user)

    Reservation::Create.for(event, current_user) if code == 0

    render json: { response_code: code, service: event.service.to_dto }
  end

  def approve
    render json:
             {
               success: Reservation::Approve.for(reservation),
               reservation: reservation.reload
             }
  end

  def disapprove
    render json:
             {
               success: Reservation::Disapprove.for(reservation),
               reservation: reservation.reload
             }
  end

  def cancel
    render json: { success: Reservation::Cancel.for(reservation) }
  end

  private

  def check_reservation_owner
    raise Exceptions::AccessDenied if reservation.user != current_user
  end

  def check_event_owner
    raise Exceptions::AccessDenied if reservation.event.service.user != current_user
  end

  def event
    @event ||= Event.find(params[:event_id])
  end

  def reservation
    @reservation ||= Reservation.find(params[:reservation_id])
  end
end
