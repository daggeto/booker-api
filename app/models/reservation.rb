class Reservation < ActiveRecord::Base
  module Status
    SUCCESS = 0
    CANT_BOOK = 1
    RESERVED_OVERLAPS = 2
    OWNED_OVERLAPS = 3
  end

  belongs_to :event
  belongs_to :user

  scope :not_reminded, lambda {
    where(reminded_at: nil)
  }
end
