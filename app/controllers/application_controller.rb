class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def render_with (code,msg)
     render :text => msg, :status => code
  end

  def render_msg (msg)
    render :text => msg
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    render :status => 403 if current_user.nil?
  end
end
