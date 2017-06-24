class EventSerializer < ActiveModel::Serializer
  delegate :reservation, to: :object

  attributes %i(
    id label description status status_label
    start_at end_at past user service_id
  )

  has_one :service
  has_one :reservation

  def label
    return unless object.reservation && object.reservation.user

    return object.reservation.user.email unless personal_info_exist?

    "#{reservation.user.first_name} #{reservation.user.last_name}"
  end

  def past
    object.past?
  end

  def status_label
    I18n.t("status.#{object.status}")
  end

  def user
    return if object.free?
    return unless object.reservation.user

    UserSerializer.new(object.reservation.user).as_json
  end

  private

  def personal_info_exist?
    true if reservation.user.first_name || reservation.user.last_name
  end
end
