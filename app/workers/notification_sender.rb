class NotificationSender
  include Sidekiq::Worker

  def perform(receivers_ids, notification_id, notification_params)
    receivers = User.find(receivers_ids)
    notification = Notification.find(notification_id)

    Notifications::Send.for(receivers, notification, notification_params)
  end
end
