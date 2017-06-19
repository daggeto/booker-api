class Device::AssignUser
  include Interactor::Initializer

  initialize_with :device, :user

  def run
    assign
  end

  private

  def assign
    device.user = user

    device.save
  end
end
