class Event::Nearest
  include Interactor::Initializer

  initialize_with :service_ids

  def run
    return find_events if service_ids.kind_of?(Array)

    find_event
  end

  private

  def find_events
    future_service_events.group_by(&:service_id).reduce({}) do |result, (service_id, events)|
      result[service_id] = events.sort_by(&:start_at).first

      result
    end
  end

  def find_event
    future_service_events.order(:start_at).first
  end

  def future_service_events
    Event
      .free
      .where(service_id: service_ids)
      .after(Event::VISIBLE_FROM_TIME.since)
  end
end
