class Diamond
  def self.make_diamond(letter)
    length = letter.ord - 'A'.ord
    rows = []
    0.upto(length) do |y|
      row = ' ' * (length * 2 + 1)
      char = (y + 'A'.ord).chr
      row[length - y] = char
      row[length + y] = char
      row += "\n"
      rows << row
    end
    rows = rows + (rows[0...-1].reverse)
    rows.join
  end
end
