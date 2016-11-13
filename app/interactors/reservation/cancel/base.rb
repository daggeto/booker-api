module Reservation::Cancel::Base
  def run
    update_event

    notify_user

    reservation.destroy
  end

  def update_event
    reservation.event.status = Event::Status::FREE

    reservation.event.save
  end
end
