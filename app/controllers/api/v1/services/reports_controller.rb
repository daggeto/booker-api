class Api::V1::Services::ReportsController < Api::BaseController
  def create
    Report::Create.for(service, current_user, report_params[:message])

    render_success(message: I18n.t('service.report_created'))
  end

  private

  def report_params
    params.permit(:service_id, :message)
  end

  def service
    @service ||= Service.find(params[:service_id])
  end
end
