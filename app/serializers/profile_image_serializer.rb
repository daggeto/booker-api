class ProfileImageSerializer < ActiveModel::Serializer
  attributes :id, :preview_url

  def preview_url
    [HOST_URL, object.image.url(:preview)].join
  end
end
