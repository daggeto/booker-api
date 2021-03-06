class Api::V1::ReservationsController < Api::BaseController
  load_and_authorize_resource id_param: :reservation_id

  def create
    result = Reservation::Validate.for(event, current_user)

    return render_conflict(message: result[:message], service: event.service) unless result[:valid]

    Reservation::Create.for(reservation_params) if result[:valid]

    render_success(message: result[:message], service: event.service.to_dto)
  end

  def approve
    render json:
             {
               success: Reservation::Approve.for(@reservation),
               reservation: @reservation.reload
             }
  end

  def disapprove
    render json: { success: Reservation::Disapprove.for(@reservation) }
  end

  def cancel_by_service
    render json: { success: Reservation::Cancel::ByService.for(@reservation) }
  end

  def cancel_by_client
    render json: { success: Reservation::Cancel::ByClient.for(@reservation) }
  end

  private

  def reservation_params
    @reservation_params ||= permited_reservation_params.merge(
      event: event,
      user: current_user
    )
  end

  def permited_reservation_params
    params.permit(:message)
  end

  def check_event_owner
    raise Exceptions::AccessDenied if reservation.event.service.user != current_user
  end

  def event
    @event ||= Event.find(params[:event_id])
  end
end
