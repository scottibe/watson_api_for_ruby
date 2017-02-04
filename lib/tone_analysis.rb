require_relative 'personality_api_caller'

class ToneAnalysis

  attr_accessor :anger, :disgust, :fear, :joy, :sadness, :analytical, :confident, :tentative, :openness, :conscientiousness, :extraversion, :agreeableness, :emotional_range

  def initialize(analysis)
    analysis.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def self.create(input)
    analysis = ToneApiCaller.new(input).scores_to_hash
    final_analysis = ToneAnalysis.new(analysis)
  end

end