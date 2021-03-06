class Api::V1::SupportIssuesController < Api::BaseController
  def create
    SupportIssue::Create.for(current_user, issue_params)

    render_success message: I18n.t('support_issue.message_sent')
  end

  private

  def issue_params
    @issue_params ||= build_params
  end

  def build_params
    params
      .permit(:message, :app_version)
      .merge(device_details_params)
      .merge(device_details: device_details.to_json)
  end

  def device_details_params
    params.require(:device_details).permit(:platform, :version)
  end

  def device_details
    params[:device_details]
  end
end
