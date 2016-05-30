class Service < ActiveRecord::Base
  belongs_to :user

  has_many :service_photos
end
