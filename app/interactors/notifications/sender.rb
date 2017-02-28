module Notifications::Sender
  def run
    send if send? && receiver
  end

  private

  def send
    NotificationSender.perform_in(Time.now, [receiver.id], notification.id, params)
  end

  def send?
    true
  end

  def reservation
    raise StandardError, '#reservation should be present'
  end

  def receiver
    raise StandardError, '#receiver should be implemented'
  end

  def sender
    raise StandardError, '#sender should be implemented'
  end

  def notification_params
    raise StandardError, '#notification_params should be implemented'
  end

  def android_params
    {}
  end

  def ios_params
    {}
  end

  private

  def params
    @params ||= { notification: { android: android, ios: ios } }
  end

  def android
    @android ||= { data: default_android_params.merge(android_params) }
      .merge(final_notification_params)
  end

  def ios
    @ios ||= default_ios_params
      .merge(ios_params)
      .merge(final_notification_params)
  end

  def default_android_params
    @default_android_params ||= {  style: 'inbox' }
  end

  def default_ios_params
    @default_ios_params ||= { sound: 'default' }
  end

  def final_notification_params
    @final_notification_params ||= notification_params.deep_merge(payload: default_payload)
  end

  def default_payload
    @default_payload ||= { notification_id: notification.id }
  end

  def notification
    @notification  ||=
      Notifications::Create.for(receiver, sender, reservation, notification_params)
  end
end
