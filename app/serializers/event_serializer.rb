class EventSerializer < ActiveModel::Serializer
  STATUSES = {
    Event::Status::FREE => 'Free',
    Event::Status::PENDING => 'Pending',
    Event::Status::BOOKED => 'Booked'
  }

  attributes %i(id label description status status_label start_at end_at past user service_id)

  has_one :service
  has_one :reservation

  def label
    return object.description unless object.reservation && object.reservation.user

    object.reservation.user.email
  end

  def past
    object.start_at < Time.zone.now
  end

  def status_label
    STATUSES[object.status]
  end

  def user
    return if object.free?
    return unless object.reservation.user

    UserSerializer.new(object.reservation.user).as_json
  end
end
