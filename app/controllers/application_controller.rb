class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  protect_from_forgery with: :exception, prepend: true

  def after_sign_in_path_for(resource)
      projects_path # Redirect to the dashboard after sign-in
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # Redirect to the homepage after sign-out
  end
end
