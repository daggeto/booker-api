class Event::Create
  include Interactor::Initializer
  include GoogleAnalyticsHelper

  initialize_with :user, :params

  def run
    event = Event.create(params)

    track_event(event)

    Reservation.create(event: event) unless params[:status] == Event::Status::FREE
  end

  private

  def track_event(event)
    GoogleAnalytics::Event::Send.for(
      GoogleAnalytics::Events::EVENT_CREATED.merge(user_id: user.id, label: ga_event_date(event))
    )
  end
end
