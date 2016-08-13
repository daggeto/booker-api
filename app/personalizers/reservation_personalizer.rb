class ReservationPersonalizer < Personalizer
  attr_reader :reservation

  def initialize(reservation)
    @reservation = reservation
  end

  def personalize
    reservation[:service_photo_url] = service_dto[:main_photo].preview_url

    reservation
  end

  private

  def service_dto
    ServiceSerializer.new(event.service).as_json
  end

  def event
    @event ||= Event.find(reservation[:event][:id])
  end
end
