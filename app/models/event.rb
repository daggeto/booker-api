class Event < ActiveRecord::Base
  include ActiveModel::Serialization

  module Status
    FREE = 'free'
    PENDING = 'pending'
    BOOKED = 'booked'

    ALL = [FREE, PENDING, BOOKED]
  end

  module BookStatus
    SUCCESS = 0
    CANT_BOOK = 1
    USER_EVENTS_OVERLAP = 2
    SERVICE_EVENTS_OVERLAP = 3
  end

  belongs_to :service
  belongs_to :user

  has_one :reservation, dependent: :destroy

  scope :in_range, lambda { |query_start_at, query_end_at|
    where('start_at <= ? AND end_at >= ?', query_end_at, query_start_at)
  }

  scope :after, lambda { |current_date|
    where('start_at > ?', current_date)
  }

  scope :free, -> { where(status: Event::Status::FREE) }

  def pending?
    status == Status::PENDING
  end

  def booked?
    status == Status::BOOKED
  end

  def free?
    status == Status::FREE
  end
end
