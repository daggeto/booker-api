class User::EnableService
  DEFAULT_NAME = 'Your Activity'
  DEFAULT_PRICE = 0
  DEFAULT_DURATION = 15

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def run
    create_service if user.service.nil?

    user.update_attributes(provider: true)
  end

  private

  def create_service
    user.service =
      Service.new(name: DEFAULT_NAME, price: DEFAULT_PRICE, duration: DEFAULT_DURATION)

    user.save
  end
end
