class Service::Publish
  attr_reader :service

  def self.for(service)
    new(service).run
  end

  def initialize(service)
    @service = service
  end

  def run
    service.update_attributes(published: true)
  end
end
