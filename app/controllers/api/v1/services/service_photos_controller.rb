class Api::V1::Services::ServicePhotosController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def index
    render json: service.service_photos.order_by_slot,
           each_serializer: ServicePhotoSerializer
  end

  def create
    new_photo = ServicePhoto::Add.for(service, uploaded_photo)

    render json: new_photo
  end

  def update
    new_photo = ServicePhoto::Replace.for(service, photo, uploaded_photo)

    render json: new_photo
  end

  private

  def photo
    @photo ||= ServicePhoto.find(params[:id])
  end

  def service
    @service ||= Service.find(params[:service_id])
  end

  def uploaded_photo
    @uploaded_photo ||= params[:file]
  end
end
