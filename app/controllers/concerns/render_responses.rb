module RenderResponses
  module ApiCodes
    SUCCESS = 0
    NOT_ALLOWED = 106
    IMPOSSIBLE_ACTION = 401
  end

  module StatusCodes
    OK = 200
    FORBIDDEN = 403
    CONFLICT = 409
  end

  def render_forbidden
    render_api_response(ApiCodes::NOT_ALLOWED, StatusCodes::FORBIDDEN)
  end

  def render_success(params)
    render_api_response(ApiCodes::SUCCESS, StatusCodes::OK, params)
  end

  def render_conflict(params)
    render_api_response(ApiCodes::IMPOSSIBLE_ACTION, StatusCodes::CONFLICT, params)
  end

  def render_api_response(code, status, params = {})
    render json: { code: code }.merge(params), status: status
  end
end
