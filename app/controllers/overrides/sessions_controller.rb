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

        Device::AssignUser.for(current_device, resource)
      end
    end

    private

    def destroy_device
      Device::UnassignUser.for(current_device)
    end
  end
end
