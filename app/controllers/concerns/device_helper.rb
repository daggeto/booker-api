module DeviceHelper
  DEVICE_TOKEN_KEY = 'HTTP_DEVICE_TOKEN'

  def current_device
    Device.where(default_device_params).first ||
      Device.create(default_device_params)
  end

  def default_device_params
    return @default_device_params if @default_device_params

    { token: params[:token] || request.headers[DEVICE_TOKEN_KEY] }
  end
end
