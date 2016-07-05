class Api::V1::User::SessionsController < Devise::SessionsController
  acts_as_token_authentication_handler_for User

  skip_filter :verify_signed_out_user, only: :destroy

  respond_to :json, :html

  def create
    sign_out(:user) if current_user
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with(user_json(resource), location: after_sign_in_path_for(resource))
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?

    respond_to_on_destroy
  end


  private

  def respond_to_on_destroy
    respond_with(success: true)
  end

  def user_json(user)
    {
      id: user.id,
      email: user.email,
      authentication_token: user.authentication_token,
    }
  end
end
