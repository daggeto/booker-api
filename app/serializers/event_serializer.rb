class EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :start_at, :end_at, :past

  has_one :service

  def past
    object.start_at < Time.zone.now
  end

  private

  def user_email
    object.user.email
  end
end
