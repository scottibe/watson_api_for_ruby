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
