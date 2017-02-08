class Service::Create
  include Interactor::Initializer

  DEFAULT_PRICE = 0
  DEFAULT_DURATION = 15

  initialize_with :user

  def run
    return if user.service

    create_service
  end

  private

  def create_service
    Service.create(
      user: user,
      price: DEFAULT_PRICE,
      duration: DEFAULT_DURATION
    )
  end
end
