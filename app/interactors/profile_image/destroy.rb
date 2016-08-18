class ProfileImage::Destroy
  include Interactor::Initializer

  initialize_with :user

  def run
    user.profile_image.destroy
  end
end
