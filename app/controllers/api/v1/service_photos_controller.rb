class Api::V1::ServicePhotosController < Api::BaseController
  load_and_authorize_resource :service_photo, only: [:destroy]

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
