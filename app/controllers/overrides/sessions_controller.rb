module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def new
      super
    end

    def create
      super
    end
  end
end
