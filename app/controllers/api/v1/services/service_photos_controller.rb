class Api::V1::Services::ServicePhotosController < Api::BaseController
  load_resource :service
  authorize_resource :service, only: [:create, :update]
  load_and_authorize_resource(
    :service_photo,
    only: [:create, :update],
    through: :service
  )

  def index
    render json: @service.service_photos.order_by_slot,
           each_serializer: ServicePhotoSerializer
  end

  def create
    new_photo = ServicePhoto::Add.for(@service, uploaded_photo)

    render json: new_photo
  end

  def update
    new_photo = ServicePhoto::Replace.for(@service, @service_photo, uploaded_photo)

    render json: new_photo
  end

  # Need for file uploading
  def update_auth_header
    return unless @resource and @resource.valid? and @client_id

    @client_id = nil unless @used_auth_by_token

    @resource.with_lock do
      @resource.extend_batch_buffer(@token, @client_id)
    end
  end

  def uploaded_photo
    @uploaded_photo ||= params[:file]
  end
end
