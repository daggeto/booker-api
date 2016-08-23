class Service::CheckPublication
  include Interactor::Initializer

  NO_ERRORS = 0
  NO_VISIBLE_EVENTS = "You don't have any visible events in future"

  initialize_with :service

  def run
    return fail(NO_VISIBLE_EVENTS) unless any_events?

    success
  end

  private

  def success
    { valid: true }
  end

  def fail(error)
    { valid: false, errors: [error] }
  end

  def any_events?
    service.events.visible.after(Time.zone.now).any?
  end
end