class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :price, :phone, :address

  has_many :service_photos
end
