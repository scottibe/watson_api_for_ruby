require_relative 'watson_api_caller'

class PersonalityAnalysis

  attr_accessor :agreeableness, :conscientiousness, :extraversion, 
                :emotional_range, :openness, :challenge, :closeness, :curiosity,
                :excitement, :harmony, :ideal, :liberty, :love, :practicality,
                :self_expression, :stability, :structure, :conservation, :openness_to_change, 
                :hedonism, :self_enhancement, :self_transcendence

  def initialize(analysis)
    analysis.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def self.create(input)
    analysis = WatsonApiCaller.new(input).scores_to_hash
    final_analysis = PersonalityAnalysis.new(analysis)
  end

end
