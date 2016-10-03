class TweetsController < ApplicationController
  before_action :only_logged_in_users, only: [:new]
  
  def new
  	@tweet = Tweet.new
  end

  def create
  	@tweet = Tweet.new(tweet_params)
  	@tweet.user_id = current_user.id
  	if @tweet.save
      redirect_to new_tweet_path, notice: "Your tweet has been successfully posted"
    else
      render 'new'
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:tweet, :user_id)
  end

  def only_logged_in_users
    unless current_user
      redirect_to root_path, notice: "Please login"
   end
 end
end
