class Api::V1::UsersController < Api::BaseController
  load_and_authorize_resource only: [:update]

  skip_before_filter :authenticate_user!, only: [:show, :current]

  def show
    render json: user
  end

  def update
    User::Update.for(current_user, user_params)

    render_success user: UserSerializer.new(current_user, info: true)
  end

  def current
    render_success UserSerializer.new(current_user || User::guest, info: true)
  end

  private

  def user_params
    params.permit(:first_name, :last_name)
  end

  def user
    @user ||= User.find(params[:id])
  end
end
