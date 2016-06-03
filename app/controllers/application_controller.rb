class ApplicationController < ActionController::Base
  include MongodbLogger::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # lock it down!
  check_authorization :unless => :devise_controller?

  # CanCan::AccessDenied exception is handled here if authorize! is failed to perform given action
  rescue_from CanCan::AccessDenied do |exception|
    # redirect_to main_app.root_url, :alert => exception.message
    #Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"     #This will weire error in log if authorize denied the access
    render :file => "#{Rails.root}/public/403.html", :status => 403, :alert => exception.message
  end

  rescue_from Mongoid::Errors::DocumentNotFound,  with: :not_found
  :private
  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :age, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :age, :email) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :age, :email, :password, :password_confirmation, :current_password, roles: []) }
  end
end
