

class Piece
  attr_accessor :pos
  attr_reader :name, :color, :symbol, :dir
  def initialize(name, pos, color)
    @name = name
    @pos = pos
    @color = color
    @dir = []
    @symbol = "   "
  end
end