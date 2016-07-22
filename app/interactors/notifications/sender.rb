module Notifications::Sender
  def run
    Notifications::Send.for(receivers, notification_params) if send?
  end

  private

  def send?
    true
  end

  def receivers
    raise StandardError, '#receivers should be implemented'
  end

  def notification_params
    raise StandardError, '#notification_params should be implemented'
  end
end
