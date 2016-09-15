class Reservation::Cancel::ByClient
  include Reservation::Cancel::Base
  include Interactor::Initializer

  initialize_with :reservation

  def notify_user
    Notifications::ReservationCanceledByClient.for(reservation)
  end
end
