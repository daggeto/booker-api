class GoogleAnalytics::Request
  API_URI = 'https://www.google-analytics.com/collect'

  VERSION = 1

  module Type
    EVENT = 'event'
  end

  class << self
    def post(params)
      RestClient.post(API_URI, default_params.merge(params))
    end

    private

    def default_params
      { v: VERSION, tid: GA_ID }
    end
  end
end
