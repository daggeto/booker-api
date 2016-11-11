class Notifications::Update
  include Interactor::Initializer

  initialize_with :notification, :params

  def run
    notification.update(params)
  end
end
