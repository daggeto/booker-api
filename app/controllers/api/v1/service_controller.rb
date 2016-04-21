class ServiceController < ApplicationController
  def index
    services = Service.all

    render json: ServiceSerializer.new(services).as_json
  end
end
