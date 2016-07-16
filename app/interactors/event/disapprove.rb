class Event::Disapprove
  attr_reader :event

  def self.for(event)
    new(event).run
  end

  def initialize(event)
    @event = event
  end

  def run
    event.status = Event::Status::FREE

    event.user = nil

    event.save
  end
end
