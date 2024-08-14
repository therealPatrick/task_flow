class ApplicationController < ActionController::Base
	include Pundit

  def after_sign_in_path_for(resource)
    tasks_path  # Redirects to the tasks index page after sign-in
  end
end
