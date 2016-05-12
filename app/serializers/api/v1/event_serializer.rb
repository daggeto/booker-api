class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :start_at, :end_at
end
