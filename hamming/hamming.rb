module Hamming
  def self.compute(str1, str2)
    raise ArgumentError if str1.length != str2.length
    arr1 = str1.split('')
    arr2 = str2.split('')
    mapped = []
    arr1.each_with_index do |chr, index|
      mapped << (arr2[index] != chr)
    end
    mapped.reduce(0) { |memo, el| memo += 1 if el; memo }
  end
end
