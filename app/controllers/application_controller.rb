class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :instantiate_controller_and_action_names

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
   
  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end
end
