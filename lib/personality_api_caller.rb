require_relative "ruby_watson_api/version"
require 'json'
require 'excon'
require "dotenv"
  Dotenv.load

class PersonalityApiCaller

  attr_accessor :url, :username, :password, :input

  def initialize(input)
    @url = "https://gateway.watsonplatform.net/personality-insights/api"
    @username = ENV["USERNAME"]
    @password = ENV["PASSWORD"]
    @input = input
  end   

  def get_raw_data
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

  def response
    name_array = []
    score_array = []
    data_object = JSON.parse(get_raw_data, :object_class => OpenStruct)
    data_object.personality.map do |type|
      name_array << type.name.downcase
      name_array.map! do |name|
        name.gsub(" ", "_")
      end  
      score_array << type.percentile
    end 
   response = Hash[name_array.zip score_array]                                           
  end  

end  
