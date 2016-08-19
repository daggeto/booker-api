class ReservationPersonalizer < Personalizer
  attr_reader :reservation

  def initialize(reservation)
    @reservation = reservation
  end

  def personalize
    reservation[:service_photo_url] = service_dto[:main_photo].preview_url
    reservation[:event] = personlized_event

    reservation
  end

  private

  def service_dto
    service = Service.find(event_dto[:service_id])

    @service_dto ||= ServiceSerializer.new(service).as_json
  end

  def event_dto
    event = Event.find(reservation[:event_id])

    @event_dto ||= EventSerializer.new(event).as_json
  end

  def personlized_event
    @personlized_event ||= EventPersonalizer.for(event_dto)
  end
end
