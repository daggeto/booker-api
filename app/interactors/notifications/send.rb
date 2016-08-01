class Notifications::Send
  include Interactor::Initializer

  API_URI = 'https://api.ionic.io/push/notifications'

  initialize_with :receivers, :notification_params

  def run
    send_request
  end

  private

  def send_request
    uri = URI.parse(API_URI)
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req['Content-Type'] = 'application/json'
    req['Authorization'] = "Bearer #{IONIC_API_KEY}"

    req.body = request_params.to_json

    https.request(req)
  end

  def request_params
    { tokens: tokens, profile: IONIC_SECURITY_PROFILE }.merge(notification: notification_params)
  end

  def tokens
    receivers.reduce([]) do |result, receiver|
      result.concat(receiver.devices.map(&:token)) if receiver.devices
    end
  end
end