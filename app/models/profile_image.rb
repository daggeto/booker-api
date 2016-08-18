class ProfileImage < ActiveRecord::Base
  include Imageable

  belongs_to :user
end
