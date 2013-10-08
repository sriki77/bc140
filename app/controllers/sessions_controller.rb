class SessionsController < ApplicationController
  def create
    user = User.where(:handle => params[:handle]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render_msg user.handle
    else
      render_with 401, user.handle
    end
  end

  def destroy
    if User.exists?(session[:user_id])
      session[:user_id] = nil
      render_msg "User Logged out"
      return
    end
    render_with 404, "User Not Found"
  end
end