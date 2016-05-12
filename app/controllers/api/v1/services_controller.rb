class Api::V1::ServicesController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json
  def index
    services = Service.all

    render json: services, each_serializer: Api::V1::ServiceSerializer
  end

  def show
    service = Service.find(params[:id])

    render json: Api::V1::ServiceSerializer.new(service)
  end

  def update
    service = Service.find(params[:id])

    success = service.update_attributes(user_update_params)

    render json: { success: success }
  end

  private

  def user_update_params
    params.permit(:name, :duration, :price, :phone, :address)
  end
end
