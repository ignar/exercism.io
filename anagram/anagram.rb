class Anagram
  attr_reader :word, :occurances

  def initialize(word)
    @word = StringNormalizer.new(word).string
    @occurances = OccurancesCounter.new(@word).occurances
  end

  def match(candidates)
    candidates.select do |candidate|
      normalized_candidate = StringNormalizer.new(candidate).string
      counter = OccurancesCounter.new(normalized_candidate)

      return false if word == normalized_candidate
      counter.occurances == occurances
    end
  end
end

class OccurancesCounter
  attr_reader :string, :occurances

  def initialize(string)
    @string = string
    array = string.split('')

    @occurances = array.reduce(Hash.new(0)) { |memo, symbol| memo[symbol] += 1; memo }
  end
end

class StringNormalizer
  attr_reader :string

  def initialize(string)
    @string = string.downcase
  end
end
