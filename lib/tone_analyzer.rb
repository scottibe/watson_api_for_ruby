require 'pp'
require 'openssl'
require 'open-uri'
require 'json'
require 'rest-client'
require 'excon'
require "dotenv"
  Dotenv.load

class ToneAnalyzer

  attr_accessor :url, :username, :password, :input

  def initialize(input)
    @url = "https://gateway.watsonplatform.net/tone-analyzer/api"
    @username = ENV["USER"]
    @password = ENV["PASS"]
    @input = input
  end 

  def get_response
    response = Excon.post(@url + "/v3/tone?version=2016-05-19/&sentences=false",
      :body             => @input,
      :headers          => {"Content-Type" => "text/html"},
      :user             => @username,
      :password         => @password)
    pp JSON.parse(response.body)
  end
end





