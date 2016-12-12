class Database::Teardown
  include Interactor::Initializer

  Models = [
    Device,
    Event,
    NotificationMessage,
    Notification,
    ProfileImage,
    Report,
    Reservation,
    ServicePhoto,
    Service,
    User
  ]

  def run
    Models.each do |model|
      model.delete_all
    end
  end
end
