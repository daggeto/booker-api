class User::Update
  include Interactor::Initializer

  initialize_with :user, :params

  def run
    user.update_attributes(params)
  end
end
