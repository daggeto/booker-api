class Notifications::MarkAsRead
  include Interactor::Initializer

  initialize_with :notification

  def run
    notification.mark_as_read! for: notification.receiver
  end
end
