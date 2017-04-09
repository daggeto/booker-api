class ApplicationController < ActionController::API
  before_filter :add_allow_credentials_headers
  skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
  before_action :set_raven_context

  def serialize_all(collection, serializer_class)
      collection.map do |item|
        serializer_class.send(:new, item)
      end
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

  def add_allow_credentials_headers
    # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5
    #
    # Because we want our front-end to send cookies to allow the API to be authenticated
    # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so
    # the browser will not reject the response
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end

  private

  def set_raven_context
    Raven.user_context(id: current_user.id, email: current_user.email) if current_user
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
