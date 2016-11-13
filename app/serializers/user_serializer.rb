class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  attribute :unread_count, if: :info?

  has_one :service
  has_one :profile_image

  def unread_count
    object.notifications.unread_by(object).size
  end

  def info?
    @instance_options[:info]
  end
end
