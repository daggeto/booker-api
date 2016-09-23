class Api::V1::Users::ReservationsController < Api::V1::BaseReservationsController
  before_action :check_owner

  def index
    reservations = serialize_all(find_reservations, ReservationSerializer).as_json

    reservations = group_reservations(reservations) if params[:group]

    render json: { reservations: reservations }
  end

  private

  def find_reservations
    user.reservations
      .joins(:event)
      .where('events.start_at > ?', Time.zone.now)
      .order('events.start_at ASC')
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
