class Notification < ActiveRecord::Base
  acts_as_readable :on => :created_at

  serialize :payload

  has_many :messages,
           class_name: 'NotificationMessage',
           foreign_key: 'notification_id',
           dependent: :destroy

  belongs_to :receiver, class_name: 'User', foreign_key: 'user_id'
  belongs_to :reservation

  def self.parse(json)
    symbolized_params = json.deep_symbolize_keys

    symbolized_params[:config]
      .slice(:profile, :tokens)
      .reverse_merge(uuid: symbolized_params[:uuid])
  end
end
