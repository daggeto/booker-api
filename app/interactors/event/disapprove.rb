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

    unassign

    event.save
  end

  private

  def unassign
    event.user = nil
  end
end
