class Api::V1::ServicesController < ApplicationController
  acts_as_token_authentication_handler_for User

  respond_to :json

  def index
    render json:
             {
               services: serialize_all(services(paginate_params), ServiceSerializer),
               more: any_more?
             },
           each_serializer: ServiceSerializer
  end

  def show
    render json: service
  end

  def update
    success = service.update_attributes(update_params)

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

  def services(paginate_params)
    Service
      .where.not(user: current_user)
      .order(updated_at: :desc)
      .paginate(paginate_params)
  end

  def any_more?
    services(page: paginate_params[:page].to_i + 1, per_page: paginate_params[:per_page]).any?
  end

  def paginate_params
    params.permit(:page, :per_page)
  end

  def update_params
    params.permit(:name, :duration, :price, :phone, :address)
  end

  def service
    @service ||= Service.find(params[:id] || params[:service_id])
  end

  def uploaded_photo
    @uploaded_photo ||= params[:file]
  end
end
