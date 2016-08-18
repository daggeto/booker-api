class ProfileImage::Add
  include Interactor::Initializer

  initialize_with :user, :uploaded_image

  def run
    user.profile_image = image

    return unless user.save

    image
  end

  private

  def image
    @image ||= ProfileImage.create(image: uploaded_image)
  end
end
