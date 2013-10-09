class ProfilesController < ApplicationController
  before_filter :authorize

  def show
    render_with 200, @current_user.profile.to_json
  end

  def create
    return render_with 400, "Invalid Request" unless params[:profile]

    @current_user.profile=Profile.new(profile_params)

    if @current_user.save
      render_msg @current_user.profile.name
    else
      render_with 500, "#{@current_user.errors.to_json} "
    end
  end

  def destroy
    if @current_user.profile.destroy
      render_msg @current_user.handle
    else
      render_with 500, "#{@current_user.errors.to_json}"
    end
  end

  def update
    return render_with 400, "Invalid Request" unless params[:profile]
     if @current_user.profile.update_attributes(profile_params)
       render_msg @current_user.profile.name
     else
       render_with 500, "#{@current_user.errors.to_json}"
     end
  end


  def profile_params
    params[:profile].permit(:name, :location, :website, :bio, :photo)
  end

end