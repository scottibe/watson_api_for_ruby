require_relative "ruby_watson_api/version"
require "pry"
require 'pp'
require "pry-inline"
require 'openssl'
require 'open-uri'
require 'json'
require 'rest-client'
require 'excon'
require "dotenv"
  Dotenv.load

class PersonalityAnalyzer

  attr_accessor :url, :username, :password

  def initialize
    @url = "https://gateway.watsonplatform.net/personality-insights/api"
    @username = ENV["USERNAME"]
    @password = ENV["PASS"]
  end   

  def get_response(input)
    response = Excon.post(@url + "/v3/profile",
    :body     => input,
    :headers  => {
      "Content-Type"     => "text/plain",
      "Content-Language" => "en",
      "Accept-Language"  => "en"
    },
    :query    => {
      "consumption_preferences" => true, 
      "raw_scores" => true,
      "version" => "10-20-2016" 
    },
    :user     => @username,
    :password => @password)

    pp JSON.parse(response.body)
  end
end



#curl version
# curl -X POST -u "{username}:{password}" --header "Content-Type: application/json" --data-binary @profile.json "https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2016-10-20&consumption_preferences=true&raw_scores=true"
# base_uri "https://gateway.watsonplatform.net/personality-insights/api/v3/consumption_preferences_true/raw_scores_true"
