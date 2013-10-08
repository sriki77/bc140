class UsersController < ApplicationController
  def create

    return render_with 400, "Invalid Request" unless params[:user];

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      render :text => @user.handle, :status => 200
    else
      render :text => "#{@user.errors.to_json} ",:status => 403
    end

  end

  def user_params
    params[:user].permit(:handle, :password,:password_confirmation)
  end
end