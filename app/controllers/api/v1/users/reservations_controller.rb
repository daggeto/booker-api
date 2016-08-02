class Api::V1::Users::ReservationsController < Api::V1::BaseController
  before_action :check_owner

  DATE_FORMAT = '%Y-%m-%d'

  def index
    reservations = serialize_all(find_reservations, ReservationSerializer).as_json

    reservations = group_reservations(reservations) if params[:group]

    render json: { reservations: reservations }
  end

  private

  def find_reservations
    user.reservations.joins(:event).where('events.start_at > ?', Time.zone.now)
  end

  def group_reservations(reservations)
    reservations.group_by do |reservation|
      reservation[:event][:start_at].strftime(DATE_FORMAT)
    end
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
