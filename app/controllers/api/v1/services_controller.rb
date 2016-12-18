class Api::V1::ServicesController < Api::BaseController
  before_action :check_service_owner, only: [:update, :publish, :unpublish]

  def index
    serialized = serialize_all(services(paginate_params), ServiceSerializer)

    render json:
             {
               services: ServicePersonalizer.for_all(serialized.as_json),
               more: any_more?
             },
           each_serializer: ServiceSerializer
  end

  def search
    serialized = serialize_all(search_services, ServiceSerializer)

    render_success(services: ServicePersonalizer.for_all(serialized.as_json))
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

  def publish
    check_result = Service::CheckPublication.for(service)

    return publish_error_response(check_result) unless check_result[:valid]

    Service::Publish.for(service)

    render_success(service: service)
  end

  def unpublish
    Service::Unpublish.for(service)
  end

  private

  def services(paginate_params)
    search = ServicesSearch.new(
      published: true,
      with_future_events: true,
      with_events_status: [Event::Status::FREE, Event::Status::PENDING],
      without_user: current_user
    )

    search.results.order(updated_at: :desc).paginate(paginate_params)
  end

  def any_more?
    services(page: paginate_params[:page].to_i + 1, per_page: paginate_params[:per_page]).any?
  end

  def paginate_params
    params.permit(:page, :per_page)
  end

  def search_services
    ServicesSearch.new(
        term: params[:term],
        published: true,
        without_user: current_user
    ).results
  end

  def update_params
    params.permit(:name, :duration, :price, :phone, :address, :description)
  end

  def publish_error_response(check_result)
    render_conflict(service: service, errors: check_result[:errors])
  end

  def service
    @service ||= Service.find(params[:id] || params[:service_id])
  end
end
