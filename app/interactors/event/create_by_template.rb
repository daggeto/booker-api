class Event::CreateByTemplate
  include Interactor::Initializer

  STEP = 1.day

  initialize_with :params

  def run
    (from..to).step(STEP).each do |day|
      create_by_template_for(Time.at(day))
    end
  end

  private

  def from
    Time.parse(params[:from]).utc.to_i
  end

  def to
    Time.parse(params[:to]).utc.to_i - STEP
  end

  def create_by_template_for(day)
    return unless !(day.saturday? || day.sunday?) || weekends?

    template.each do |time_range|
      start_at = combine_date_time(day, time_range[:start_at])
      end_at = combine_date_time(day, time_range[:end_at])

      event_params = default_event_params.merge(start_at: start_at, end_at: end_at)

      return unless valid?(event_params)

      Event::Create.for(user, event_params)
    end
  end

  def weekends?
    params[:weekends]
  end

  def combine_date_time(day, time)
     [Time.at(day).strftime("%Y-%m-%d"), time].join(' ')
  end

  def valid?(event_params)
    result = Event::Validate.for(user, event_params)

    result[:valid]
  end

  def template
    params[:template]
  end

  def user
    params[:user]
  end

  def default_event_params
    @default_event_params ||= {
      service_id: user.service.id,
      status: Event::Status::FREE
    }
  end
end
