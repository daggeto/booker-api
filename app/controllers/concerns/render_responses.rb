module RenderResponses
  def render_forbidden
    render_api_response(106, 403)
  end

  def render_api_response(code = 0, status = 200)
    render(json: { code: code }, status: status)
  end
end