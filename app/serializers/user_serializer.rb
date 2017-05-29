class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :roles, :is_guest
  attribute :unread_count, if: :info?

  has_one :service
  has_one :profile_image

  def unread_count
    return 0 if object.has_role?(:guest)

    object.notifications.unread_by(object).size
  end

  def roles
    object.roles.to_a.map(&:to_s)
  end

  def is_guest
    return object.guest?
  end

  def info?
    @instance_options[:info]
  end
end
