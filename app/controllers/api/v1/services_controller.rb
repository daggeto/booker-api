class Api::V1::ServicesController < Api::V1::BaseController
  before_action :check_service_owner, only: [:update]

  def index
    serialized = serialize_all(services(paginate_params), ServiceSerializer)

    render json:
             {
               services: ServicePersonalizer.for_all(serialized.as_json),
               more: any_more?
             },
           each_serializer: ServiceSerializer
  end

  def create
    Service::Create.for(current_user)

    render json: current_user.service.to_dto
  end

  def show
    render json: service
  end

  def update
    success = service.update_attributes(update_params)

    render json: { success: success }
  end

  private

  def services(paginate_params)
    Service
      .published
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
    params.permit(:name, :duration, :price, :phone, :address, :published)
  end

  def service
    @service ||= Service.find(params[:id] || params[:service_id])
  end
end
