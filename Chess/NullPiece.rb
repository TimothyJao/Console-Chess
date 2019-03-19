require "singleton"
require_relative "piece.rb"
class NullPiece < Piece
  include Singleton
  def initialize
    super(" ", [], " ")
  end

  def pos_moves(board)
    nil
  end
  def nil?
    true
  end
end