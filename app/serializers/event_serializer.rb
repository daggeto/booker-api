class EventSerializer < ActiveModel::Serializer
  attributes :id, :label, :description, :status, :start_at, :end_at, :past

  has_one :service

  def label
    return object.user.email  if object.user

    object.description
  end

  def past
    object.start_at < Time.zone.now
  end

  private

  def user_email
    object.user.email
  end
end
