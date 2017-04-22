class Api::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::RequestForgeryProtection
  include ActionController::Serialization
  include RenderResponses

  UNTRACKABLE_REQUESTS = ['show_selected', 'current']

  before_action :authenticate_user!
  before_action :track_requests

  respond_to :json

  def check_service_owner
    raise Exceptions::AccessDenied if service.try(:user) != current_user
  end

  def check_event_owner
    raise Exceptions::AccessDenied if event.service.try(:user) != current_user
  end

  def check_owner
    raise Exceptions::AccessDenied if user != current_user
  end

  def check_reservation_owner
    raise Exceptions::AccessDenied if reservation.user != current_user
  end

  def current_user
    super
  end

  def service
    nil
  end

  def event
    nil
  end

  def track_requests
    return if UNTRACKABLE_REQUESTS.include?(params[:action])

    GoogleAnalytics::PageView::Send.for(
      user_id: current_user.id,
      host: 'timespex.com',
      page: "#{request.method} : #{URI.unescape(request.original_fullpath)}",
      title: params[:action]
    )
  end

  rescue_from Exceptions::AccessDenied, with: :render_forbidden
end
