module Reservation::Cancel::Base
  def run
    update_event

    reservation.destroy

    notify_user
  end

  def update_event
    reservation.event.status = Event::Status::FREE

    reservation.event.save
  end
end
