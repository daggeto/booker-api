class Api::V1::UsersController < Api::V1::BaseController
  def show
    render json: user
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
