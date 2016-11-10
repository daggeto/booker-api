class Service < ActiveRecord::Base
  DURATIONS = [15, 30, 45, 60]

  belongs_to :user

  has_many :service_photos, dependent: :destroy
  has_many :events, dependent: :destroy

  def to_dto
    serialized = ServiceSerializer.new(self).as_json

    ServicePersonalizer.for(serialized)
  end
end
