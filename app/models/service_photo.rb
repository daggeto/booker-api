class ServicePhoto < ActiveRecord::Base
  has_attached_file :image, styles: { preview: ['254x254#', :png] }

  validates_attachment_content_type :image, content_type: ['image/jpeg']
  validates_attachment_file_name :image, matches: [/jpe?g\Z/]
  validates_attachment_size :image, in: 0..5.megabyte

  scope :order_by_slot, -> { order(:slot) }

  belongs_to :service
end
