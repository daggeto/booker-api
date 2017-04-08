class GoogleAnalytics::Event::Send
  include Interactor::Initializer

  TYPE = 'event'
  PARAM_MAPPING = {
    user_id: 'cid',
    category: 'ec',
    action: 'ea',
    label: 'el',
    value: 'ev'
  }

  initialize_with :params

  def run
    request_params = params.reduce({}) do |carry, (key, value)|
      carry[PARAM_MAPPING[key].to_sym] = value

      carry
    end

    GoogleAnalytics::Request.post(default_params.merge(request_params))
  end

  private

  def default_params
    { t: GoogleAnalytics::Request::Type::EVENT }
  end
end
