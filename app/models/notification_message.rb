class NotificationMessage < ActiveRecord::Base
  belongs_to :notification

  def self.parse(json)
    symbolized_params = json.deep_symbolize_keys

    symbolized_params.slice(:uuid, :status, :created, :error)
      .reverse_merge(notification_uuid: symbolized_params[:notification])
  end
end
