class Api::V1::User::RegistrationsController < Devise::RegistrationsController
  respond_to :json, :html
end
