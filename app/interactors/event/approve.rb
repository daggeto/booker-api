class Event::Approve
  attr_reader :event

  def self.for(event)
    new(event).run
  end

  def initialize(event)
    @event = event
  end

  def run
    event.status = Event::Status::BOOKED

    event.save
  end
end
