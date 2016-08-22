class EventSerializer < ActiveModel::Serializer
  STATUSES = {
    Event::Status::FREE => 'Free',
    Event::Status::PENDING => 'Pending',
    Event::Status::BOOKED => 'Booked'
  }

  attributes %i(id description status status_label start_at end_at past user service_id)

  has_one :service
  has_one :reservation

  def past
    object.start_at < Time.zone.now
  end

  def status_label
    STATUSES[object.status]
  end

  def user
    return if object.free?

    UserSerializer.new(object.reservation.user).as_json
  end
end
