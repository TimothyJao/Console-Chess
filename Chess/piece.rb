class Piece
  attr_accessor :pos
  attr_reader :name, :color
  def initialize(name, pos, color)
    @name = name
    @pos = pos
    @color = color
  end

end