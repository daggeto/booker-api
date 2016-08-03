module ReservationHelper
  def event
    reservation.event
  end

  def service
    event.service
  end

  def booking_at
    event.start_at.strftime('%B %d %H:%M')
  end
end
