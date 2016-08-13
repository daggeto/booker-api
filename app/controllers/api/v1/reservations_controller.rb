class Api::V1::ReservationsController < Api::V1::BaseController
  before_action :check_event_owner, only: [:approve, :disapprove]
  before_action :check_reservation_owner, only: [:cancel]

  def create
    result = Reservation::Validate.for(event, current_user)

    return render_conflict(message: result[:message], service: event.service) unless result[:valid]

    Reservation::Create.for(event, current_user) if result[:valid]

    render_success(message: result[:message], service: event.service)
  end

  def approve
    render json:
             {
               success: Reservation::Approve.for(reservation),
               reservation: reservation.reload
             }
  end

  def disapprove
    render json: { success: Reservation::Disapprove.for(reservation) }
  end

  def cancel
    render json: { success: Reservation::Cancel.for(reservation) }
  end

  private

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
