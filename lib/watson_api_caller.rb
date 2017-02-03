require_relative "ruby_watson_api/version"
require 'json'
require 'excon'
require "dotenv"
  Dotenv.load

class WatsonApiCaller

  attr_accessor :url, :username, :password, :input

  def initialize(input)
    @url = "https://gateway.watsonplatform.net/personality-insights/api"
    @username = ENV["USERNAME"]
    @password = ENV["PASSWORD"]
    @input = input
  end   

  def get_data
    response = Excon.post(@url + "/v3/profile",
    :body     => @input,
    :headers  => {
      "Content-Type"            => "text/plain",
      "Content-Language"        => "en",
      "Accept-Language"         => "en"
    },
    :query    => {
      "raw_scores"              => true,
      "consumption_preferences" => true, 
      "version"                 => "10-20-2016" 
    },
    :user                       => @username,
    :password                   => @password)

    response.body
  end

   def scores_to_hash
    array = []
    score_array = []
    data_object = JSON.parse(get_data, :object_class => OpenStruct)
    array += [data_object.personality, data_object.needs, data_object.values]
    array.each do |result|
      result.each do |score|
        score_array += [score.name.gsub(" ", "_").gsub("-", "_").downcase.to_sym, score.percentile]
      end 
    end 
    hash = Hash[*score_array]
  end

end
