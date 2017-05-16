class RegistrationsController < Devise::RegistrationsController
  def new
    @organization = if params[:user].try([:organization_params])
      Organization.new(params[:user][:organization_params])
    else
      Organization.new
    end
    super
  end
end
