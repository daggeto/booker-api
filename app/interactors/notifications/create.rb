class Notifications::Create
  include Interactor::Initializer

  initialize_with :receiver, :sender, :reservation, :params

  def run
    Notification.create(attributes)
  end

  private

  def attributes
    params
      .slice(:title, :message, :payload)
      .merge(receiver: receiver, sender: sender, reservation: reservation)
  end
end
