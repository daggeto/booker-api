class Api::V1::UsersController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def show
    render json: Api::V1::UserSerializer.new(user), root: false
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
