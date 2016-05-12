class Event < ActiveRecord::Base
  module Status
    FREE = 'free'
    PENDING = 'pending'
    BOOKED = 'booked'

    ALL = [FREE, PENDING, BOOKED]
  end

  belongs_to :service
  belongs_to :user
end
