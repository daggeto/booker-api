class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :service

  has_one :event
  has_one :user

  def service
    ServiceSerializer.new(object.event.service).as_json
  end
end
