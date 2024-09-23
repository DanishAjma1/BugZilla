class Users::RegistrationsController < Devise::RegistrationsController
  # For adding custom behavior, you can override any Devise methods.

  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :role ])
    end
end
