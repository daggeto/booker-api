class Event::Delete
  include Interactor::Initializer

  initialize_with :event

  def run
    event.destroy

    notify_user unless event.free?
  end

  private

  def notify_user
    Notifications::ReservationCanceledByService.for(event.reservation)
  end
end
