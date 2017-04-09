class GoogleAnalytics::PageView::Send
  include Interactor::Initializer

  PARAM_MAPPING = {
    user_id: 'cid',
    host: 'dh',
    page: 'dp',
    title: 'dt'
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
    { t: GoogleAnalytics::Request::Type::PAGE_VIEW }
  end
end
