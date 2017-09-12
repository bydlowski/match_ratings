class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # def instantiate_user
  #   @user = User.new
  # end

  # def after_sign_in_path_for(resource)
  #   p 'AAAA'
  #   redirect_to admin_path
  # end

  # def after_sign_in_path_for(resource)
  #   sign_in_url = new_user_session_url
  #   if request.referer == sign_in_url
  #     super
  #   else
  #     stored_location_for(resource) || request.referer || public_settings_path
  #   end
  # end

  # def after_sign_up_path_for(resource)
  #   sign_in_url = new_user_session_url
  #   if request.referer == sign_in_url
  #     super
  #   else
  #     stored_location_for(resource) || request.referer || public_settings_path
  #   end
  # end

  # def after_sign_out_path_for(resource)
  #   sign_in_url = new_user_session_url
  #   if request.referer == sign_in_url
  #     super
  #   else
  #     stored_location_for(resource) || request.referer || public_settings_path
  #   end
  # end

  protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:user])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   else
  #     redirect_to admin_session_path, :notice => 'Wrong username/password combination'
  #   end
  # end

  private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end
end
