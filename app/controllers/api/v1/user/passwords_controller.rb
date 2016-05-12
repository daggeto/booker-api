class Api::V1::User::PasswordsController < Devise::PasswordsController
  respond_to :json, :html
end
