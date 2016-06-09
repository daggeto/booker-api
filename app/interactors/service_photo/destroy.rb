class ServicePhoto::Destroy
  attr_reader :service_photo, :options

  def self.for(service_photo, options = {})
    new(service_photo, options).run
  end

  def initialize(service_photo, options)
    @service_photo = service_photo
    @options = options
  end

  def run
    return false unless service_photo.destroy

    recalculate_slots if options[:recalculate_slots]

    true
  end

  private

  def recalculate_slots
    current_slot = service_photo.slot

    photos_left = service_photos.where('slot > ?', current_slot)

    photos_left.each do |photo|
      photo.update_attribute(:slot, photo.slot - 1)
    end
  end

  def service_photos
    service_photo.service.service_photos
  end

  def slots_count
    service_photo.service.service_photos.count
  end
end
