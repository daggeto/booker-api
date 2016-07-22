module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    before_action :destroy_device, only: [:destroy]

    private

    def destroy_device
      current_user.devices.where(client_id: @client_id).destroy_all
    end
  end
end
