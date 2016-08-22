module Notifications::Sender
  def run
    Notifications::Send.for([receiver], notification_params) if send? && receiver
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
end
