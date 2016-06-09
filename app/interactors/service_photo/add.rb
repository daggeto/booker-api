class ServicePhoto::Add
  attr_reader :service, :photo_file, :options

  def self.for(service, photo_file, options = {})
    new(service, photo_file, options).run
  end

  def initialize(service, photo_file, options)
    @service = service
    @photo_file = photo_file
    @options = options
  end

  def run
    return false if photos_count == 5

    service.service_photos.create(image: photo_file, slot: slot)
  end

  private

  def slot
    options[:slot] || photos_count + 1
  end

  def photos_count
    service.service_photos.count
  end
end
