class Reservation::Create
  include Interactor::Initializer
  include GoogleAnalyticsHelper

  initialize_with :params

  def run
    reservation

    update_event
    track_event

    notify_provider
  end

  private

  def track_event
    GoogleAnalytics::Event::Send.for(
      GoogleAnalytics::Events::EVENT_BOOKED.merge(user_id: user.id, label: ga_event_date(event))
    )
  end

  def update_event
    event.status = Event::Status::PENDING

    event.save
  end

  def reservation
    @reservation ||= Reservation.create(params)
  end

  def notify_provider
    Notifications::ConfirmReservation.for(reservation)
  end

  def event
    @event ||= params[:event]
  end

  def user
    @user ||= params[:user]
  end

  def message
    @message ||= params[:message]
  end
end
