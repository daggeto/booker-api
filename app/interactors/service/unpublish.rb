class Service::Unpublish
  attr_reader :service

  def self.for(service)
    new(service).run
  end

  def initialize(service)
    @service = service
  end

  def run
    service.update_attributes(published: false)
  end
end
