class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :provider

  has_one :service
end
