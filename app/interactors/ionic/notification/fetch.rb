class Ionic::Notification::Fetch
  include Interactor::Initializer

  initialize_with :uuid

  def run
    notification = ::Notification.parse(response['data'])

    notification[:messages] = messages

    notification
  end

  private

  def response
    raw_response = Ionic::Request.get("notifications/#{uuid}")

    JSON.parse(raw_response.body)
  end

  def messages
    Ionic::Notification::Messages::FetchAll.for(uuid)
  end
end
