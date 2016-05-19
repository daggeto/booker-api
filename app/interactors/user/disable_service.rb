class User::DisableService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def run
    user.update_attributes(provider: false)
  end
end
