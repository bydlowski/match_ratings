class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!

  # def new
  #   super
  # end
  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)
  #   if sign_in(resource_name, resource)
  #     respond_with resource, location: after_sign_in_path_for(resource)
  #   else
  #     respond_with resource, location: root_path
  #   end
  #   # yield resource if block_given?
  #   # respond_with resource, location: after_sign_in_path_for(resource)
  # end
end
