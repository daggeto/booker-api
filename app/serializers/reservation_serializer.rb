class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :event_id

  has_one :event
  has_one :user
end
