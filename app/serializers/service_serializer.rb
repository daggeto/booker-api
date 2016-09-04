class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :price, :phone, :address, :main_photo, :published,
             :description

  has_many :service_photos

  def service_photos
    object.service_photos.order_by_slot
  end

  def main_photo
    return random_photo_json if object.service_photos.empty?

    ServicePhotoSerializer.new(object.service_photos.first)
  end

  private

  def random_photo_json
    { preview_url: random_photo_url }
  end

  def random_photo_url
    "http://lorempixel.com/#{ServicePhoto::PHOTO_WIDTH}/#{ServicePhoto::PHOTO_HEIGHT}/abstract/"
  end
end
