module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    include RenderResponses

    before_action :destroy_device, only: [:destroy]

    def create
      super do |resource|
        GoogleAnalytics::Event::Send.for(
          GoogleAnalytics::Events::LOGIN.merge(user_id: resource.id, label: resource.email)
        )
      end
    end

    private

    def destroy_device
      current_user.devices.where(client_id: @client_id).destroy_all
    end
  end
end
