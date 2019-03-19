require_relative "piece.rb"
require_relative "stepable.rb"

class King < Piece

  include Stepable

  def initialize(name, pos, color)
    super
    if @color == :black
      @symbol = " ♚ "
    else
      @symbol = " ♔ "
    end
  end
end

class Knight < Piece

  include Stepable

  def initialize(name, pos, color)
    super
    if @color == :black
      @symbol = " ♞ "
    else
      @symbol = " ♘ "
    end
  end
end