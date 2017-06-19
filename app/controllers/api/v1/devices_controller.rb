class Api::V1::DevicesController < Api::BaseController
  skip_before_filter :authenticate_user!, only: [:create]

  def create
    current_device.update(device_params)
  end

  private

  def device_params
    @device_params ||= params.permit(:token, :platform)
  end
end
