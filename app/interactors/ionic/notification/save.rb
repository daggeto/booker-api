class Ionic::Notification::Save
  include Interactor::Initializer

  initialize_with :uuid, :reservation

  def run
    notification.reservation = reservation

    notification.save
  end

  private

  def notification
    @notification ||= Ionic::Notification::Fetch.for(uuid)
  end
end
