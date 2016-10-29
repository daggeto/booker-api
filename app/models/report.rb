class Report < ActiveRecord::Base
  belongs_to :service
  belongs_to :reporter, class_name: 'User', foreign_key: 'user_id'
end
