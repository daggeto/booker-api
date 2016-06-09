class ServicePhoto::Replace
  attr_reader :service, :old_photo, :new_photo_file

  def self.for(service, old_photo, new_photo_file)
    new(service, old_photo, new_photo_file).run
  end

  def initialize(service, old_photo, new_photo_file)
    @service = service
    @old_photo = old_photo
    @new_photo_file = new_photo_file
  end

  def run
    return false unless ServicePhoto::Destroy.for(old_photo)

    ServicePhoto::Add.for(service, new_photo_file, slot: old_photo.slot)
  end
end
