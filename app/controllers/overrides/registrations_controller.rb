module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    def create
      super do |resource|
        GoogleAnalytics::Event::Send.for(
          GoogleAnalytics::Events::REGISTRATION.merge(user_id: resource.id, label: resource.email)
        )
      end
    end
  end
end
