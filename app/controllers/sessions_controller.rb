class SessionsController < ApplicationController
  def create
    user = User.where(:handle => params[:handle]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render :text => "Welcome back, #{user.handle}"
    else
      render :text => "Invalid credentials, please provide handle and password"
    end
  end

  def destroy
    user = User.find(session[:user_id])
    session[:user_id] = nil
    render :text => "#{user.handle} Logged out "
  end
end