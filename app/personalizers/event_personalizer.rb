class EventPersonalizer < Personalizer
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def personalize
    event[:service_name] = service_dto[:name]

    event
  end

  private

  def service_dto
    service = Service.find(event[:service_id])

    @service_dto ||= ServiceSerializer.new(service).as_json
  end
end
