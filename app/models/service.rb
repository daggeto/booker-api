class Service < ActiveRecord::Base
  DURATIONS = [15, 30, 45, 60]

  belongs_to :user

  has_many :service_photos
end
