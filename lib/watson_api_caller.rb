require_relative "ruby_watson_api/version"
require 'json'
require 'excon'
require "dotenv"
require 'active_support'
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

  def personality_hash
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







# def scores_to_hash
#     array = []
#     score_array = []
#     data_object = JSON.parse(get_raw_data, :object_class => OpenStruct)
#     array += [data_object.personality, data_object.needs, data_object.values]
#     array.each do |result|
#       result.each do |score|
#         score_array += [score.name.gsub(" ", "_").gsub("-", "_").downcase.to_sym, score.percentile]
#       end 
#     end 
#     hash = Hash[*score_array]
#     binding.pry
#   end

# end






#   def big_five_response
#     name_array = []
#     score_array = []
#     data_object = JSON.parse(get_raw_data, :object_class => OpenStruct)
#     data_object.personality.map do |type|
#       name_array << type.name.downcase
#       name_array.map! do |name|
#         name.gsub(" ", "_")
#       end  
#       score_array << type.percentile
#     end 
#    response = Hash[name_array.zip score_array]                                           
#   end  

#   def needs_response
#     needs_array = []
#     data_object = JSON.parse(get_raw_data, :object_class => OpenStruct)
#     data_object.needs.map do |need|
#       needs_array << need.name.downcase!
#       needs_array << need.percentile
#     end  
#     hash = Hash[*needs_array]
#   end


# end  