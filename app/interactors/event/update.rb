class Event::Update
  include Interactor::Initializer

  initialize_with :event, :params

  def run
    event.attributes = params

    Reservation.create(event: event) if changed_from_free?

    event.save
  end

  private

  def changed_from_free?
    return unless event.status_change

    event.status_change.first == Event::Status::FREE &&
      Event::Status::NOT_FREE.include?(event.status_change.last)
  end
end
