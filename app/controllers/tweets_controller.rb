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

  def converse
    return render_with 400, "Invalid Request" unless params[:id]
    tweet=Tweet.find(params[:id])
    return render_with 404, "Tweet #{params[:id]} not found" unless tweet
    tweets=Tweet.where(:converse => tweet.converse)
    render_msg tweets.to_json
  end

  def list
    twts= Array.new(@current_user.tweets)
    twts.sort { |t1, t2| t1.id<=>t2.id }
    @current_user.following.each { |f| (twts << f.tweets).flatten!}
    twts.sort { |t1, t2| t1.id<=>t2.id }
    render json: twts, each_serializer: TweetSerializer,root: false
  end



end

