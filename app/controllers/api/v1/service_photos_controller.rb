class Api::V1::ServicePhotosController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def destroy
    render json: { success: ServicePhoto::Destroy.for(service_photo, recalculate_slots: true) }
  end

  private

  def service_photo
    @service_photo ||= ServicePhoto.find(params[:id])
  end
end