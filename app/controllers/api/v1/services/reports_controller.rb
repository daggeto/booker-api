class Api::V1::Services::ReportsController < Api::BaseController
  skip_before_filter :authenticate_user!

  def create
    Report::Create.for(service, user, report_params[:message])

    render_success(message: I18n.t('service.report_created'))
  end

  private

  def report_params
    params.permit(:service_id, :message)
  end

  def service
    @service ||= Service.find(params[:service_id])
  end

  def user
    current_user || User::guest
  end
end
