class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def authorize_user
    if !current_user.is_admin
      head :forbidden
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation, organization_attributes: [:name, :email, :facebook, :twitter, :telephone_number, :legally_formed])
    end
  end
end
