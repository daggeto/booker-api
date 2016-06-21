class Api::V1::User::SessionsController < Devise::SessionsController
  respond_to :json, :html

  def create
    sign_out(:user) if current_user
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with user_json(resource), location: after_sign_in_path_for(resource)
  end


  private

  def user_json(user)
    {
      id: user.id,
      email: user.email,
      authentication_token: user.authentication_token,
    }
  end
end
