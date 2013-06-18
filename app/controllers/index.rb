get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
 # gets the most recent tweet from 
 @user = User.find_or_create_by_username(params[:username])
 # if @user.tweets.empty? || @user.tweets_stale?
 #    @user.fetch_tweets!
 # end

 unless @user.tweets.empty?
  if @user.tweets_stale?
    @status = "stale"
  else
    @status = "fresh"
  end
  @tweets = @user.tweets
 end

 erb :recent_tweets
end

post '/:username/tweets' do
  content_type 'html'
  user = User.find_by_username(params[:username])
  user.fetch_tweets!
  @tweets = user.tweets
  erb :tweets
end


get '/:username/bio' do
 # gets the most recent tweet from 
 @user = User.find_or_create_by_username(params[:username])
 # if @user.tweets.empty? || @user.tweets_stale?
 #    @user.fetch_tweets!
 # end

 unless @user.tweets.empty?
  if @user.tweets_stale?
    @status = "stale"
  else
    @status = "fresh"
  end
 end

 erb :bio
end

post '/:username/bio' do
  @user = User.find_by_username(params[:username])
  @user.fetch_info!
  @tweets = @user.tweets
  erb :info
end
