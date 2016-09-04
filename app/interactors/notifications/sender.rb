module Notifications::Sender
  def run
    Notifications::Send.for([receiver], params) if send? && receiver
  end

  private

  def send?
    true
  end

  def receiver
    raise StandardError, '#receivers should be implemented'
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
    { notification: { android: android, ios: ios } }
  end

  def android
    { data: default_android_params.merge(android_params) }.merge(notification_params)

  end

  def ios
    { data: default_ios_params.merge(ios_params) }.merge(notification_params)
  end

  def default_android_params
    {  style: 'inbox' }
  end

  def default_ios_params
    {}
  end
end
