class Reservation::Remind
  include Interactor::Initializer

  initialize_with :reservation

  def run
    Notifications::ReservationReminder.for(reservation)
  end
end
