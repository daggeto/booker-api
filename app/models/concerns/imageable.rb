module Imageable
  extend ActiveSupport::Concern
  PHOTO_WIDTH = 350
  PHOTO_HEIGHT = 450

  included do
    has_attached_file :image,
                      styles: {
                        preview: ["#{PHOTO_WIDTH}x#{PHOTO_HEIGHT}#", :png],
                      },
                      url: "/images/:hash.:extension",
                      hash_secret: "Wr793OkTRlyFjUXXzA6y"

    validates_attachment_content_type :image, content_type: ['image/jpeg']
    validates_attachment_file_name :image, matches: [/jpe?g\Z/]
    validates_attachment_size :image, in: 0..5.megabyte
  end
end
