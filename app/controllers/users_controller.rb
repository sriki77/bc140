class UsersController < ApplicationController
  before_filter :authorize, :except => :create

  def create

    return render_with 400, "Invalid Request" unless params[:user]

    @user = User.new(user_params)

    if @user.save
      render_msg @user.handle
    else
      render_with 403, "#{@user.errors.to_json} "
    end

  end

  def follow
    return render_with 400, "Invalid Request" unless params[:handle]
    user_to_follow=User.where(:handle => params[:handle]).first
    return render_with 404, "User with handle #{params[:handle]} not found" unless user_to_follow
    user_to_follow.followers << @current_user
    @current_user.reload; user_to_follow.reload
    render_msg "Following #{user_to_follow.handle}"
  end

  def unfollow
    return render_with 400, "Invalid Request" unless params[:handle]
    user_to_follow=User.where(:handle => params[:handle]).first
    return render_with 404, "User with handle #{params[:handle]} not found" unless user_to_follow
    if user_to_follow.followers.delete @current_user
      @current_user.reload; user_to_follow.reload
      render_msg "Unfollowed #{user_to_follow.handle}"
    else
      render_msg "Unfollow did not have any effect, may not be a follower"
    end
  end

  def followers
    render_msg @current_user.followers.to_json
  end

  def following
    render_msg @current_user.following.to_json
  end

  def user_params
    params[:user].permit(:handle, :password, :password_confirmation)
  end
end