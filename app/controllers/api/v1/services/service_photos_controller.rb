class Api::V1::Services::ServicePhotosController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def create
    binding.pry
    service.service_photos.build(image: uploaded_photo)

    if service.save
      result =  { success: true }
    else
      result = { success: false }
    end

    render json: result
  end

  private

  def service
    @service ||= Service.find(params[:service_id])
  end

  def uploaded_photo
    @uploaded_photo ||= params[:file]
  end
end
