class Api::V11::ServicesController < Api::BaseController
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

  private

  def services(paginate_params)
    search = ServicesSearch.new(
      published: true,
      with_future_events: true,
      with_events_status: [Event::Status::FREE, Event::Status::PENDING],
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
    ).results
  end
end
