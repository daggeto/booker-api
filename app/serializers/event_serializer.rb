class EventSerializer < ActiveModel::Serializer
  attributes :id, :label, :description, :status, :start_at, :end_at

  def label
    "#{object.description} - #{user_email}"
  end

  private

  def user_email
    object.user.email if object.user
  end
end
