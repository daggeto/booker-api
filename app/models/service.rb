class Service < ActiveRecord::Base
  DURATIONS = [15, 30, 45, 60]

  belongs_to :user

  has_many :service_photos
  has_many :events


  def to_dto
    serialized = ServiceSerializer.new(self).as_json

    ServicePersonalizer.for(serialized)
  end
end
