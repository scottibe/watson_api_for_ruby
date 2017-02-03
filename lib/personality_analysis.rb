require_relative 'watson_api_caller'

class PersonalityAnalysis

  attr_accessor :agreeableness, :conscientiousness, :extraversion, 
                :emotional_range, :openness, :challenge, :closeness, :curiosity,
                :excitement, :harmony, :ideal, :liberty, :love, :practicality,
                :self_expression, :stability, :structure, :conservation, :openness_to_change, 
                :hedonism, :self_enhancement, :self_transcendence

  def initialize(response_hash)
    response_hash.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def self.create(input)
    response_hash = WatsonApiCaller.new(input).personality_hash
    final_analysis = PersonalityAnalysis.new(response_hash)
  end

end
