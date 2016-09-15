class Reservation::Cancel::ByService
  include Reservation::Cancel::Base
  include Interactor::Initializer

  initialize_with :reservation

  def notify_user
    Notifications::ReservationCanceledByService.for(reservation)
  end
end
