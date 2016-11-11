class Ionic::Notification::Update
  include Interactor::Initializer

  initialize_with :notification, :uuid

  def run
    notification.update(ionic_notification.merge(messages: messages))
  end

  private

  def ionic_notification
    @ionic_notification ||= Ionic::Notification::Fetch.for(uuid)
  end

  def messages
    @messages ||= fetch_messages
  end

  def fetch_messages
    Ionic::Notification::Messages::FetchAll.for(uuid).map do |message|
      NotificationMessage.new(message)
    end
  end
end
