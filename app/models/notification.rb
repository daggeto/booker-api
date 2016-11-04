class Notification < ActiveRecord::Base
  has_many :messages,
           class_name: 'NotificationMessage',
           foreign_key: 'notification_id',
           dependent: :destroy

  belongs_to :reservation

  def self.parse(json)
    symbolized_params = json.deep_symbolize_keys

    params = symbolized_params[:config]
               .slice(:profile, :tokens)
               .reverse_merge(uuid: symbolized_params[:uuid])

    self.new(params)
  end
end
