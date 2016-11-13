class Notifications::MarkAllAsRead
  include Interactor::Initializer

  initialize_with :user

  def run
    user.notifications.mark_as_read! :all, for: user
  end
end
