class EventSerializer < ActiveModel::Serializer
  STATUSES = {
    Event::Status::FREE => 'Free',
    Event::Status::PENDING => 'Pending',
    Event::Status::BOOKED => 'Booked'
  }

  attributes :id, :description, :status, :status_label, :start_at, :end_at, :past, :service_id

  has_one :service
  has_one :reservation

  def past
    object.start_at < Time.zone.now
  end

  def status_label
    STATUSES[object.status]
  end

  private

  def user_email
    object.user.email
  end
end
