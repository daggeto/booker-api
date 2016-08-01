class Api::V1::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::RequestForgeryProtection
  include ActionController::Serialization
  include RenderResponses

  before_action :authenticate_user!

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

  def current_user
    super
  end

  def service
    nil
  end

  def event
    nil
  end

  rescue_from Exceptions::AccessDenied, with: :render_forbidden
end
