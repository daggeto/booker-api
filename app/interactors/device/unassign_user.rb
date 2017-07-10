class Device::UnassignUser
  include Interactor::Initializer

  initialize_with :device

  def run
    unassign
  end

  private

  def unassign
    device.user = nil

    device.save
  end
end
