require 'twitter'
require 'json'
require "dotenv"

class TwitterApiCall
  Dotenv.load

  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["CONSUMER_KEY"]
    config.consumer_secret = ENV["CONSUMER_SECRET"]
    config.access_token = ENV["ACCESS_KEY"]
    config.access_token_secret = ENV["ACCESS_SECRET"]
  end

  def user_tweets(twitter_handle)
    tweets = []
    twit = @@client.user_timeline(twitter_handle, options = {:count => 200})
    twit.each do |tweet|
      tweets << tweet.text 
    end  
    tweets.join(" ") 
  end  

end   
              