class Service::Create
  DEFAULT_NAME = I18n.t('service.new_service_name')
  DEFAULT_PRICE = 0
  DEFAULT_DURATION = 15

  attr_reader :user

  def self.for(user)
    new(user).run
  end

  def initialize(user)
    @user = user
  end

  def run
    return if user.service

    create_service
  end

  private

  def create_service
    Service.create(
      user: user,
      name: DEFAULT_NAME,
      price: DEFAULT_PRICE,
      duration: DEFAULT_DURATION
    )
  end
end
