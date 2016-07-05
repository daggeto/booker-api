class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable

  has_one :service
  has_many :events
end
