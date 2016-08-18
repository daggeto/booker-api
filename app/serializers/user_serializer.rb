class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_one :service
  has_one :profile_image
end
