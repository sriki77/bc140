class TweetsController < ApplicationController
  before_filter :authorize


  def show
    return render_with 400, "Invalid Request" unless params[:id]
    tweet=Tweet.find(params[:id])
    if tweet
      render_msg tweet.to_json
    else
      render_with 404, "Tweet #{params[:id]} not found"
    end
  end

  def index
    render_with 200, @current_user.tweets.to_json
  end

  def create
    return render_with 400, "Invalid Request" unless params[:tweet]

    @current_user.tweets << Tweet.new(tweet_params)

    if @current_user.save
      render_msg @current_user.tweets[-1].to_json
    else
      render_with 500, "#{@current_user.errors.to_json} "
    end
  end

  def destroy
    return render_with 400, "Invalid Request" unless params[:id]
    if Tweet.destroy(params[:id])
      @current_user.reload
      render_msg @current_user.handle
    else
      render_with 500, "Failed to delete tweet with id #{params[:id]}"
    end
  end

  def update
    return render_with 400, "Invalid Request" unless params[:tweet] || params[:id]
    tweet=Tweet.find(params[:id])
    if tweet
      if tweet.update_attributes(tweet_params)
        @current_user.reload
        render_msg tweet.to_json
        return
      end
    end
    render_with 500, "Failed to update tweet with id #{params[:id]}"
  end


  def tweet_params
    params[:tweet].permit(:msg, :converse, :targeted)
  end

end