class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :instantiate_controller_and_action_names
  before_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      flash[:alert] = "Sorry, you need to login or register to do that."
      redirect_to new_user_session_path
    else
      flash[:alert] = "Sorry, you don't have permission to see that."
      redirect_to root_path
    end
  end
   
  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  # After sign in, redirect to previous page
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  add_breadcrumb "home", :root_path
end
