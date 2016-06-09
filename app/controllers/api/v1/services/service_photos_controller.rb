class Api::V1::Services::ServicePhotosController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def create
    render json: { success: ServicePhoto::Add.for(service, uploaded_photo) }
  end

  def update
    render json: { success: ServicePhoto::Replace.for(service, photo, uploaded_photo) }
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
