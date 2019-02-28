class Brackets
  def self.paired?(string)
    new(string).paired?
  end

  def initialize(string)
    @stack = []
    @paired = true
    string.each_char do |chr|
      break unless @paired

      case chr
      when '[', '{', '('
        stack.push(chr)
      when ']', '}', ')'
        if stack.last == OPPENING[chr]
          stack.pop
        else
          @paired = false
        end
      end
    end
  end

  def paired?
    @paired && stack.empty?
  end

  private

  OPPENING = {
    ']' => '[',
    '}' => '{',
    ')' => '(',
  }.freeze

  attr_accessor :stack, :paired
end
