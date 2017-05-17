class Event::CreateSplitted
  include Interactor::Initializer

  initialize_with :user, :params

  def run
    (start_at..end_at).step(split_by).each do |start_at_step|
      create_event(Time.at(start_at_step), Time.at(start_at_step + split_by))
    end
  end

  private

  def create_event(start_at, end_at)
    event_params = params[:event_params].merge(start_at: start_at, end_at: end_at)

    Event::Create.for(user, event_params)
  end

  def split_by
    params[:split_by]
  end


  def start_at
    params[:start_at].to_i
  end

  def end_at
    params[:end_at].to_i - split_by
  end
end
