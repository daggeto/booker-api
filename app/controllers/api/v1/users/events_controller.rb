class Api::V1::Users::EventsController < Api::V1::BaseController
  before_action :check_owner

  DATE_FORMAT = '%Y-%m-%d'

  def index
    events = serialize_all(find_events, EventSerializer).as_json

    events = group_events(events) if params[:group]

    render json: { events: events }
  end

  private

  def find_events
    current_user.events.after(Time.zone.now)
  end

  def group_events(events)
    events.group_by do |event|
      event[:start_at].strftime(DATE_FORMAT)
    end
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
