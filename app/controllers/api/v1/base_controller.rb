class Api::V1::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::RequestForgeryProtection
  include ActionController::Serialization

  before_action :authenticate_user!

  respond_to :json


  def update_auth_header
    super
  end

  def set_user_by_token(mapping=nil)
    super
  end

  def current_user
    super
  end
end
