class Api::V1::Users::ProfileImagesController < Api::V1::BaseController
  include Api::V1::FileUploadable

  def create
    add_image
  end

  def update
    ProfileImage::Destroy.for(current_user)

    add_image
  end

  private

  def add_image
    profile_image = ProfileImage::Add.for(current_user, uploaded_image)

    render_success(profile_image: ProfileImageSerializer.new(profile_image).as_json)
  end

  def uploaded_image
    @uploaded_image ||= params[:file]
  end
end
