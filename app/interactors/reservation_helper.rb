module ReservationHelper
  def event
    reservation.event
  end

  def service
    event.service
  end

  def booking_at
    I18n.l event.start_at, format: :notification
  end
end
