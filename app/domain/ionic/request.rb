class Ionic::Request
  API_URI = 'https://api.ionic.io/push/'

  class << self
    def post(path, params)
      RestClient.post("#{API_URI}/#{path}", default_params.merge(params).to_json, header)
    end

    def get(path, params = {})
      RestClient.get("#{API_URI}/#{path}", { params: params }.merge(header).merge(default_params) )
    end

    private

    def header
      { content_type: :json, 'Authorization' => "Bearer #{IONIC_API_KEY}" }
    end

    def default_params
      { profile: IONIC_SECURITY_PROFILE }
    end
  end
end
