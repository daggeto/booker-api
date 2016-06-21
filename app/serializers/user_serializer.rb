class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :provider

  has_one :service
end
