class Notifications::Send
  include Interactor::Initializer

  initialize_with :receivers, :notification, :notification_params

  def run
    send_request
  end

  private

  def send_request
    response = Ionic::Request.post('notifications', { tokens: tokens }.merge(notification_params))

    uuid = uuid(response)

    Ionic::Notification::Update.for(notification, uuid)
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
