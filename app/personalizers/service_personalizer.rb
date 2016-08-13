class ServicePersonalizer
  def self.for_all(services)
    services.each do |service|
      self.for(service)
    end
  end

  def self.for(service)
    new(service).personalize
  end

  attr_reader :service

  def initialize(service)
    @service = service
  end

  def personalize
    service[:nearest_event] = EventSerializer.new(nearest_event).as_json if nearest_event

    service
  end

  private

  def nearest_event
    @nearest_event ||= service_model.events
      .free
      .where('start_at > ?', Event::VISIBLE_FROM_TIME.since)
      .order(:start_at).first
  end

  def service_model
    @service_model ||= Service.find(service[:id])
  end
end
