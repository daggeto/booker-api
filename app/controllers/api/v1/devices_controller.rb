class Api::V1::DevicesController < Api::V1::BaseController
  def create
    current_user.devices.create(device_params)
  end

  private

  def device_params
    request_params = params.permit(:token, :platform)

    request_params.merge(client_id: @client_id)
  end
end