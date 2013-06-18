class Tweet < ActiveRecord::Base
  # Remember to create a migration!

  belongs_to :user

  def stale?
    (Time.now - self.date_tweeted_on) > self.user.stale_threshold
  end


end
