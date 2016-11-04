class Reservation < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  has_many :notifications, dependent: :destroy

  scope :not_reminded, lambda {
    where(reminded_at: nil)
  }
end
