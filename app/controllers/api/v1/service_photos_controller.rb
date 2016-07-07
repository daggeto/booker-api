class Api::V1::ServicePhotosController < Api::V1::BaseController
  def destroy
    render json: { success: ServicePhoto::Destroy.for(service_photo, recalculate_slots: true) }
  end

  private

  def service_photo
    @service_photo ||= ServicePhoto.find(params[:id])
  end
end