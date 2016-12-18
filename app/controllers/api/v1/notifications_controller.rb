class Api::V1::NotificationsController < Api::BaseController
  before_action :check_owner, only: [:mark_as_read]

  def index
    render json: { notifications: serialize_all(notifications, NotificationSerializer) }
  end

  def mark_as_read
    Notifications::MarkAsRead.for(notification)
  end

  def mark_all_as_read
    Notifications::MarkAllAsRead.for(current_user)
  end

  private

  def notifications
    current_user.notifications.order(created_at: :desc)
  end

  def check_owner
    raise Exceptions::AccessDenied if notification.receiver != current_user
  end

  def notification
    @notification ||= Notification.find(params[:notification_id])
  end

  def left_unread
    current_user.notifications.unread_by(current_user).size
  end
end
