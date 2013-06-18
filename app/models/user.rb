class User < ActiveRecord::Base
  # Remember to create a migration!

  before_save :avg_stale_threshold

  has_many :tweets

  def tweets_stale?
    self.tweets.order("created_at").first.stale?
  end

  def fetch_tweets!
    api_response = Twitter.user_timeline(self.username)[0...10]
    api_response.each do |tweet|
      self.tweets << Tweet.find_or_create_by_text(text: tweet[:text], date_tweeted_on: tweet[:created_at])
    end
    self.save
  end

  def fetch_info!
    user = Twitter.user(self.username)
    self.description = user.description
    self.profile_image_url = user.profile_image_url
    self.save
  end

  def avg_stale_threshold

    return self.stale_threshold if self.tweets.length < 2 

    array_of_dates = []

    self.tweets.each do |tweet|
       array_of_dates  << tweet.date_tweeted_on
    end
    
    tweet_date_diffs = []

    array_of_dates.each_cons(2) do |pair|
      tweet_date_diffs << (pair[0] - pair[1])
    end

    self.stale_threshold = tweet_date_diffs.reduce(:+)/tweet_date_diffs.length.to_f    
  end

end
