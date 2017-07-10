module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    include RenderResponses
    include DeviceHelper

    before_action :destroy_device, only: [:destroy]

    def create
      super do |resource|
        GoogleAnalytics::Event::Send.for(
          GoogleAnalytics::Events::LOGIN.merge(user_id: resource.id, label: resource.email)
        )

        Device::AssignUser.for(current_device, resource) if current_device
      end
    end

    private

    def destroy_device
      return Device::UnassignUser.for(current_device) if current_device

      current_user.devices.where(client_id: @client_id).destroy_all
    end
  end
end
