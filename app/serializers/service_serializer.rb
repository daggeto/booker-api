class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :price
end
