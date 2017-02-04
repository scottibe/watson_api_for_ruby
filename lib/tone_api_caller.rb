require 'pp'
require 'json'
require 'excon'
require "dotenv"
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

  def scores_to_hash  #needs to be refactored
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
    score_hash = Hash[*score_array]   
  end

end