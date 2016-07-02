class Event::Delete
  attr_reader :event

  def self.for(event)
    new(event).run
  end

  def initialize(event)
    @event = event
  end

  def run
    event.destroy
  end
end
