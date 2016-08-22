class Event < ActiveRecord::Base
  include ActiveModel::Serialization

  module Status
    FREE = 'free'
    PENDING = 'pending'
    BOOKED = 'booked'

    VISIBLE = [FREE, PENDING]

    NOT_FREE = [PENDING, BOOKED]

    ALL = [FREE, PENDING, BOOKED]
  end

  VISIBLE_FROM_TIME = 15.minutes

  belongs_to :service

  has_one :reservation, dependent: :destroy

  scope :in_range, lambda { |query_start_at, query_end_at|
    where('start_at <= ? AND end_at >= ?', query_end_at, query_start_at)
  }

  scope :after, lambda { |current_date|
    where('start_at > ?', current_date)
  }

  scope :visible, -> { where(status: Status::VISIBLE) }
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

  def past?
    start_at < Time.zone.now
  end
end
