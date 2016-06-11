class Api::V1::ServicesController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def index
    services = Service.all

    render json: services,
           each_serializer: ServiceSerializer,
           request: request
  end

  def show
    render json: service, request: request
  end

  def update
    success = service.update_attributes(user_update_params)

    render json: { success: success }
  end

  def upload_photo
    service.service_photos.build(image: uploaded_photo)

    if service.save
      result =  { success: true }
    else
      result = { success: false }
    end

    render json: result
  end

  private

  def user_update_params
    params.permit(:name, :duration, :price, :phone, :address)
  end

  def service
    @service ||= Service.find(params[:id] || params[:service_id])
  end

  def uploaded_photo
    @uploaded_photo ||= params[:file]
  end
end
