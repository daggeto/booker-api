class Api::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::RequestForgeryProtection
  include ActionController::Serialization
  include CanCan::ControllerAdditions
  include RenderResponses
  include DeviceHelper

  UNTRACKABLE_REQUESTS = ['show_selected', 'current']

  before_action :authenticate_user!
  before_action :track_requests

  respond_to :json

  def

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

  def service
    nil
  end

  def event
    nil
  end

  def track_requests
    return if UNTRACKABLE_REQUESTS.include?(params[:action])

    GoogleAnalytics::PageView::Send.for(
      user_id: google_analytics_user_id,
      host: 'timespex.com',
      page: "#{request.method} : #{URI.unescape(request.original_fullpath)}",
      title: params[:action]
    )
  end

  def google_analytics_user_id
    return current_user.id if current_user

    return current_device.token if current_device
  end

  rescue_from Exceptions::AccessDenied, with: :render_forbidden
  rescue_from CanCan::AccessDenied, with: :render_forbidden
end
