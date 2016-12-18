class Api::V1::BaseReservationsController < Api::BaseController
  DATE_FORMAT = '%Y-%m-%d'

  def group_reservations(reservations)
    reservations.group_by do |reservation|
      reservation[:event][:start_at].strftime(DATE_FORMAT)
    end
  end
end
