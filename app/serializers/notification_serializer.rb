class NotificationSerializer < ActiveModel::Serializer
  attributes %i(id title message payload created_at unread avatar_photo)

  has_one :receiver
  has_one :reservation

  def unread
    object.unread?(object.receiver)
  end

  def avatar_photo
    return service_photo if object.sender.is_a?(Service)

    user_photo
  end

  private

  def service_photo
    ServiceSerializer.new(object.sender).as_json[:main_photo] if object.sender
  end

  def user_photo
    UserSerializer.new(object.sender).as_json[:profile_image] if object.sender
  end
end
