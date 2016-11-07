class Api::V1::UsersController < Api::V1::BaseController
  skip_before_filter :authenticate_user!, only: [:show]

  def show
    render json: user
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
