class Api::V1::UsersController < Api::V1::BaseController
  skip_before_filter :authenticate_user!, only: [:show]

  def show
    render json: user
  end

  def current
    render_success UserSerializer.new(current_user, info: true)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
