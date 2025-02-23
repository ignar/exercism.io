module Hamming
  def self.compute(str1, str2)
    raise ArgumentError if str1.length != str2.length
    mapped = []
    0.upto(str1.length) do |index|
      mapped << (str1[index] != str2[index])
    end
    mapped.reduce(0) { |memo, el| memo += 1 if el; memo }
  end
end
