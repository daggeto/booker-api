class Ionic::Notification::Messages::FetchAll
  include Interactor::Initializer

  initialize_with :notification_uuid

  def run
    response = Ionic::Request.get("notifications/#{notification_uuid}/messages")

    messages = JSON.parse(response.body)

    messages['data'].map { |message| NotificationMessage.parse(message) }
  end
end
