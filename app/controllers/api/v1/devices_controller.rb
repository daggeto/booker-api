class Api::V1::DevicesController < Api::BaseController
  skip_before_filter :authenticate_user!, only: [:create]

  def create
    current_device.update(device_params) if current_device
  end

  private

  def device_params
    return @device_params if @device_params

    @device_params = params.permit(:token, :platform)

    @device_params[:client_id] = @client_id

    @device_params[:user] = current_user if current_user

    @device_params
  end
end
