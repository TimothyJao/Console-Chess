require_relative "piece.rb"
require_relative "slideable.rb"

class Bishop < Piece

  include Slideable

  def initialize(name, pos, color)
    super
    if @color == :black
      @symbol = " ♝ "
    else
      @symbol = " ♗ "
    end
    @dir = [:diagonal]
  end
end

class Queen < Piece

  include Slideable

  def initialize(name, pos, color)
    super
    if @color == :black
      @symbol = " ♛ "
    else
      @symbol = " ♕ "
    end
    @dir = [:straight, :diagonal]
  end
end

class Rook < Piece

  include Slideable
  attr_accessor :moved
  def initialize(name, pos, color)
    super
    @moved = false
    if @color == :black
      @symbol = " ♜ "
    else
      @symbol = " ♖ "
    end
    @dir = [:straight]
  end
end