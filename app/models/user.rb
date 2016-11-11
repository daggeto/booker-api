class User < ActiveRecord::Base
  acts_as_reader

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :service
  has_one :profile_image

  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :devices

  # def valid_token?(token, client_id='default')
  #   super
  # end
  #
  # def create_new_auth_token(client_id=nil)
  #   super
  # end
  #
  # def token_can_be_reused?(token, client_id)
  #   updated_at = self.tokens[client_id]['updated_at'] || self.tokens[client_id][:updated_at]
  #
  #   res = Time.parse(updated_at) > Time.now - DeviseTokenAuth.batch_request_buffer_throttle
  #   result = {
  #     res: res,
  #     token: token,
  #     updated_at: Time.parse(self.tokens[client_id]['updated_at']),
  #     current_token_hash: self.tokens[client_id]['token'],
  #     last_token: self.tokens[client_id]['last_token']
  #   }
  #   logger.debug("[token_can_be_reused?] - #{result.inspect}")
  #
  #   super
  # end
  #
  # def token_is_current?(token, client_id)
  #   token_hash = self.tokens[client_id]['token'] || self.tokens[client_id][:token]
  #
  #   res = ::BCrypt::Password.new(token_hash) == token
  #
  #   result = {
  #     res: res,
  #     token: token,
  #     updated_at: Time.parse(self.tokens[client_id]['updated_at']),
  #     current_token_hash: self.tokens[client_id]['token'],
  #     last_token: self.tokens[client_id]['last_token']
  #   }
  #
  #   logger.debug("[token_is_current?] - #{result.inspect}")
  #
  #   super
  # end

end
