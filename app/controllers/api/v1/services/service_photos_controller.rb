class Api::V1::Services::ServicePhotosController < Api::V1::BaseController
  before_action :check_service_owner, only: [:create, :update]

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

  # Need for file uploading
  def update_auth_header
    return unless @resource and @resource.valid? and @client_id

    @client_id = nil unless @used_auth_by_token

    @resource.with_lock do
      @resource.extend_batch_buffer(@token, @client_id)
    end # end lock
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
