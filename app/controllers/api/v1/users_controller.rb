class Api::V1::UsersController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def show
    render json: Api::V1::UserSerializer.new(user), root: false
  end

  def toggle_provider_settings
    if provider_flag
      User::EnableService.new(user).run
    else
      User::DisableService.new(user).run
    end

    render json: { success: true, user: Api::V1::UserSerializer.new(user.reload)}, root: false
  end

  private

  def serialize(user)

  end

  def provider_flag
    params['provider_flag']
  end

  def user
    @user ||= User.find(params[:id])
  end
end
