class Api::V1::ServicePhotosController < Api::V1::BaseController
  before_action :check_service_owner, only: [:destroy]

  def destroy
    render json: { success: ServicePhoto::Destroy.for(service_photo, recalculate_slots: true) }
  end

  private

  def service
    service_photo.service
  end

  def service_photo
    @service_photo ||= ServicePhoto.find(params[:id])
  end

end