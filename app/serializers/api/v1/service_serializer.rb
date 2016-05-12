class Api::V1::ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :price, :phone, :address
end
