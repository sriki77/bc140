class UsersController < ApplicationController
  before_filter :authorize, :except => :create

  def create

    return render_with 400, "Invalid Request" unless params[:user];

    @user = User.new(user_params)

    if @user.save
      render_msg @user.handle
    else
      render_with 403, "#{@user.errors.to_json} "
    end

  end

  def followers
      render_msg @current_user.followers.to_json
  end

  def user_params
    params[:user].permit(:handle, :password, :password_confirmation)
  end
end