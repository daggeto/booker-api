class Event::Create
  include Interactor::Initializer

  initialize_with :params

  def run
    event = Event.create(params)

    Reservation.create(event: event) unless params[:status] == Event::Status::FREE
  end
end
