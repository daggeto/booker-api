module ReservationHelper
  def event
    reservation.event
  end

  def service
    event.service
  end

  def booking_at
    event.start_at.strftime('%H:%M %B %-d ')
  end
end
