module DeviceHelper
  DEVICE_TOKEN_KEY = 'HTTP_DEVICE_TOKEN'

  def current_device
    return unless device_token

    Device.where(default_device_params).first ||
      Device.create(default_device_params)
  end

  def default_device_params
    @default_device_params ||= { token: device_token }
  end

  def device_token
    @device_token ||= params[:token] || request.headers[DEVICE_TOKEN_KEY]
  end
end
