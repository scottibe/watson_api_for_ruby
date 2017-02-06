require 'json'
require 'excon'
require 'dotenv'
require_relative './twitter/twitter_api'
  Dotenv.load

class ToneApiCaller   

  attr_accessor :url, :username, :password, :input

  def initialize(input)
    @url = "https://gateway.watsonplatform.net/tone-analyzer/api"
    @username = ENV["APIUSER"]
    @password = ENV["APIKEY"]
    @input = input
  end 

  def get_response
    response = Excon.post(@url + "/v3/tone?version=2016-05-19/&sentences=false",
      :body             => @input,
      :headers          => {"Content-Type" => "text/html"},
      :user             => @username,
      :password         => @password)

    data = JSON.parse(response.body)
  end

  def scores_to_hash  
    score_array = []
    data = get_response
    data["document_tone"]["tone_categories"][0]["tones"].each do |tone|
      score_array += [tone["tone_name"].downcase.to_sym, tone["score"]]
    end   
    data["document_tone"]["tone_categories"][1]["tones"].each do |tone|
      score_array += [tone["tone_name"].downcase.to_sym, tone["score"]]
    end
    data["document_tone"]["tone_categories"][2]["tones"].each do |tone|
      score_array += [tone["tone_name"].gsub(" ", "_").downcase.to_sym, tone["score"]]
    end  
    hash = Hash[*score_array]   
    hash = hash.each_pair do |k, v|
      hash[k] = (v * 100).to_i
    end  
  end

end