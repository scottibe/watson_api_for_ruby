 require 'json'
 require 'pry'
 require_relative 'personality_api_caller'

class BigFiveScores

  attr_accessor :agreeableness, :conscientiousness, :extraversion, :emotional_range, :openness

  def initialize(response_hash)
    response_hash.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def name_results
    hash = Hash[self.names.zip self.percentile_scores]   
  end  

  def self.create(input)
    response_hash = PersonalityApiCaller.new(input).response
    new_object = BigFiveScores.new(response_hash)
  end

end














#def self.percentile_scores
  #   scores = []
  #   analyzer = PersonalityAnalyzer.new(input)
  #   @@data = analyzer.get_response
  #   data_object = JSON.parse(@@data, :object_class => OpenStruct)
  #   data_object.personality.map do |type|
  #     scores << type.percentile
  #   end 
  #   scores                                              
  # end  

  # def overall_scores
  #   scores = []
  #   #response = PersonalityAnalyzer.new(File.open("super.txt", "r"))
  #   #data = @@response.get_response
  #   data_object = JSON.parse(@@data, :object_class => OpenStruct)
  #   data_object.personality.map do |type|
  #     scores << type.raw_score
  #   end 
  #   scores                                             
  # end

  #  def names
  #   name_array = []
  #   #response = PersonalityAnalyzer.new(File.open("super.txt", "r"))
  #   #data = @@response.get_response
  #   data_object = JSON.parse(@@data, :object_class => OpenStruct)
  #   data_object.personality.map do |type|
  #     name_array << type.name.downcase
  #     name_array.map! do |name|
  #       name.gsub(" ", "_")
  #     end  
  #   end
  #   name_array                                            
  # end 