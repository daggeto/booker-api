class ServicePhoto < ActiveRecord::Base
  include Imageable

  scope :order_by_slot, -> { order(:slot) }

  belongs_to :service
end
