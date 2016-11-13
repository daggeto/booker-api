class NotificationSerializer < ActiveModel::Serializer
  attributes %i(id title message payload created_at unread)

  has_one :receiver
  has_one :reservation

  def unread
    object.unread?(object.receiver)
  end
end
