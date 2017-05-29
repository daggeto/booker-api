class User < ActiveRecord::Base
  include RoleModel

  before_create :set_default_role

  roles :standard, :guest

  acts_as_reader

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_one :service, dependent: :destroy
  has_one :profile_image, dependent: :destroy

  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :support_issues, dependent: :destroy
  has_many :devices, dependent: :destroy

  def self.guest
    User.new(roles: [:guest])
  end

  def setup_new_reader
    #overrides unread gem method which clears all notifications for new user
  end

  def standard?
    has_role? :standard
  end

  def guest?
    roles.empty? || has_role?(:guest)
  end

  # Overides devise auth token
  def token_validation_response
    UserSerializer.new(self, info: true)
  end

  private

  def set_default_role
    self.roles = [:standard]
  end
end
