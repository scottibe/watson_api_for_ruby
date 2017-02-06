require 'pry'
require 'twitter'
require 'tweetstream'
require 'json'
require 'excon'
require "dotenv"

class TwitterApiCall
  Dotenv.load

  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["CONSUMER_KEY"]
    config.consumer_secret = ENV["CONSUMER_SECRET"]
    config.access_token = ENV["ACCESS_KEY"]
    config.access_token_secret = ENV["ACCESS_SECRET"]
  end

  def user_tweets(user_name)
    tweets = []
    twit = @@client.user_timeline(user_name, options = {:count => 200})
    twit.each do |tweet|
      tweets << tweet.text 
    end  
    tweets.join(" ") 
  end  

end   

 

 
              