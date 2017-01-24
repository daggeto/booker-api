class Event::AvailableDays
  include Interactor::Initializer

  initialize_with :service, :date

  def run
    result = {}

    (number_beginning_of_week..number_end_of_week).each do |day|
      result[day] = available_days.key?(day) ? available_days[day] : 0
    end

    result
  end

  private

  def number_beginning_of_week
    @number_beginning_of_week ||= date.beginning_of_week.yday
  end

  def number_end_of_week
    @number_end_of_week ||= date.end_of_week.yday
  end

  def available_days
    @available_days ||=
      grouped_events.reduce({}) do |result, (day, events)|
        result[day] = events.count

        result
      end
  end

  def grouped_events
    @grouped_events ||=
      service
        .events
        .free
        .start_in_range(date, date.end_of_week)
        .group_by { |event| event.start_at.yday }
  end
end
