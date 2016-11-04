class Notifications::Send
  include Interactor::Initializer

  initialize_with :receivers, :params

  def run
    send_request
  end

  private

  def send_request
    response = Ionic::Request.post('notifications', { tokens: tokens }.merge(params))
    Rails.logger.debug(response.body.as_json)

    uuid(response)
  end

  def tokens
    receivers.reduce([]) do |result, receiver|
      result.concat(receiver.devices.map(&:token)) if receiver.devices
    end
  end

  def uuid(response)
    parsed = JSON.parse(response.body)

    parsed['data']['uuid']
  end
end
