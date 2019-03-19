require_relative "piece.rb"
require_relative "display.rb"

class Board

  attr_accessor :grid
  def self.create_board
    board = Board.new
    
    #Making Pawns
    board.grid[1].each_index { |col| board.grid[1][col] = Piece.new("Pawn", [1, col], "Black") }
    board.grid[6].each_index { |col| board.grid[6][col] = Piece.new("Pawn", [6, col], "White") }
    #Making rest of board
    piece_array = ["Rook", "Knight", "Bishop", "Queen", "King", "Bishop", "Knight", "Rook"]
    piece_array.each_with_index do |piece, col|
      board.grid[0][col] = Piece.new(piece, [0,col],"Black")
      board.grid[7][col] = Piece.new(piece, [7,col],"White")
    end
    board
  end
  def initialize
    @grid = Array.new(8){ Array.new(8) }
  end
  def show_board
    display = Display.new(self)
    display.display
  end

  def move_piece(start_pos, end_pos)
    raise "Invalid position!" if check_pos(start_pos)
    raise "Invalid position!" if check_pos(end_pos)
    piece = self.grid[start_pos.first][start_pos.last]
    raise "This ain't a piece!" if piece.nil?
    piece.pos = end_pos
    self.grid[start_pos.first][start_pos.last] = nil
    self.grid[end_pos.first][end_pos.last] = piece
  end

  def check_pos(pos)
    !(0..7).include?(pos.first) || !(0..7).include?(pos.last) 
  end

end

board = Board.create_board
board.show_board