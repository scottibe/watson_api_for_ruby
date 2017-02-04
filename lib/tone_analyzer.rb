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
    data["document_tone"]["tone_categories"].each do |x|
      x.each do |blob|
        blob.each do |cob|
          
            binding.pry

        end 
      end 
    end        
    
  end
 


end

# def scores_to_hash
#     score_array = []
#     data = get_response
#     data["document_tone"]["tone_categories"][0]["tones"].each do |tone|
#       score_array += [tone["score"], tone["tone_name"].downcase.to_sym]
#     end   
#     data["document_tone"]["tone_categories"][1]["tones"].each do |tone|
#       score_array += [tone["score"], tone["tone_name"].downcase.to_sym]
#     end
#     data["document_tone"]["tone_categories"][2]["tones"].each do |tone|
#       score_array += [tone["score"], tone["tone_name"].gsub(" ", "_").downcase.to_sym]
#     end  
#     score_hash = Hash[*score_array]
#     binding.pry
    
#   end







#get_response["document_tone"]["tone_categories"]


#(File.open("/Users/scottbewick/Development/code/mytext.rtf", "r"))
#get_response["document_tone"]["tone_categories"]