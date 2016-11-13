class Event::Delete
  include Interactor::Initializer

  initialize_with :event

  def run
    notify_user unless event.free?

    event.destroy
  end

  private

  def notify_user
    Notifications::ReservationCanceledByService.for(event.reservation)
  end
end
