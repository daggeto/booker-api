class Api::V1::Services::ReservationsController < Api::V1::BaseReservationsController
  def index
    reservations = serialize_all(find_reservations, ReservationSerializer).as_json

    reservations = group_reservations(reservations) if params[:group]

    render json: { reservations: reservations }
  end

  private

  def find_reservations
    Reservation
      .joins(:event)
      .where(events: { service_id: params[:service_id] } )
      .where('events.start_at > ?', Time.zone.now)
      .order('events.start_at ASC')
  end
end
