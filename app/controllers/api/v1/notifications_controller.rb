class Api::V1::NotificationsController < Api::V1::BaseController
  before_action :check_owner, only: [:mark_as_read]

  def index
    render json: { notifications: serialize_all(notifications, NotificationSerializer) }
  end

  def mark_as_read
    notification.mark_as_read! for: current_user
  end

  def mark_all_as_read
    current_user.notifications.mark_as_read! :all, for: current_user
  end

  private

  def notifications
    current_user.notifications.order(:created_at)
  end

  def check_owner
    raise Exceptions::AccessDenied if notification.receiver != current_user
  end

  def notification
    @notification ||= Notification.find(params[:notification_id])
  end
end
