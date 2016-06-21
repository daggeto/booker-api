class ServicePhotoSerializer < ActiveModel::Serializer
  attributes :id, :title, :preview_url

  def preview_url
    [HOST_URL, object.image.url(:preview)].join
  end
end
