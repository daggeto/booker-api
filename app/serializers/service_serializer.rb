class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :price, :phone, :address

  has_many :service_photos

  def service_photos
    object.service_photos.order(:slot)
  end
end
