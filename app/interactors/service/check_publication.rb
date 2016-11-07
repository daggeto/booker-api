class Service::CheckPublication
  include Interactor::Initializer

  NO_ERRORS = 0
  NO_VISIBLE_EVENTS = I18n.t('publish.no_events')
  NO_PHOTOS_UPLOADED = I18n.t('publish.no_photos')

  initialize_with :service

  def run
    return fail(NO_VISIBLE_EVENTS) unless any_events?

    return fail(NO_PHOTOS_UPLOADED) unless service.service_photos.any?

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
