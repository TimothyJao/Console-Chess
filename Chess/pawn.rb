require_relative "piece.rb"

class Pawn < Piece


  def initialize(name, pos, color)
    super
    if @color == :black
      @symbol = " ♟ "
    else
      @symbol = " ♙ "
    end
  end

  def possible_move?(board, pos, diagonal=false)
    return false unless (0..7).include?(pos.first) && (0..7).include?(pos.last)
    return false if board[pos].nil? && diagonal
    return false if board[pos].color == self.color && diagonal
    return false if !diagonal && !board[pos].nil?
    true
  end
  def pos_moves(board)
    moves = []
    short = short_moves
    short.each do |move|
      diagonal = (move.last != 0)
      move = [move.first + pos.first, move.last + pos.last]
      moves << move if possible_move?(board, move, diagonal)
    end
    moves
  end

  def short_moves
    case self.color
    when :white
      short_moves = [[-1,0], [-1,1], [-1,-1]]
      short_moves << [-2,0] if pos.first == 6
    when :black
      short_moves = [[1,0], [1,1], [1,-1]]
      short_moves << [2,0] if pos.first == 1
    end
    short_moves
  end
end