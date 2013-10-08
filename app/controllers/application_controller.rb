class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
      render text: "Hello World"
  end

  def render_with (code,msg)
     render :text => msg, :status => code
  end
end
