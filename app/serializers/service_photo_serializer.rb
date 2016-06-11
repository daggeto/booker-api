class ServicePhotoSerializer < ActiveModel::Serializer
  attributes :id, :title, :preview_url

  def preview_url
    [url_prefix, object.image.url(:preview)].join
  end

  private

  def url_prefix
    "#{request.protocol}#{request.host}:#{request.port}"
  end

  def request
    @request_param ||= @instance_options[:request]
  end
end
