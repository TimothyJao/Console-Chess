require_relative "piece.rb"
require_relative "display.rb"
require_relative "NullPiece.rb"
require_relative "slideable_pieces.rb"
require_relative "stepable_pieces.rb"
require_relative "pawn.rb"

class Board

  attr_accessor :grid
  def self.create_board
    board = Board.new
    #Making Pawns
    board.grid[1].each_index { |col| board.grid[1][col] = Pawn.new(:pawn, [1, col], :black) }
    board.grid[6].each_index { |col| board.grid[6][col] = Pawn.new(:pawn, [6, col], :white) }
    #Making rest of board
    piece_array = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook]
    piece_array.each_with_index do |piece, col|
      case piece
      when :rook
        board.grid[0][col] = Rook.new(piece, [0,col],:black)
        board.grid[7][col] = Rook.new(piece, [7,col],:white)
      when :knight
        board.grid[0][col] = Knight.new(piece, [0,col],:black)
        board.grid[7][col] = Knight.new(piece, [7,col],:white)
      when :bishop
        board.grid[0][col] = Bishop.new(piece, [0,col],:black)
        board.grid[7][col] = Bishop.new(piece, [7,col],:white)
      when :queen
        board.grid[0][col] = Queen.new(piece, [0,col],:black)
        board.grid[7][col] = Queen.new(piece, [7,col],:white)
      when :king
        board.grid[0][col] = King.new(piece, [0,col],:black)
        board.grid[7][col] = King.new(piece, [7,col],:white)
      end
    end
    board
  end
  def initialize
    @grid = Array.new(8){ Array.new(8, NullPiece.instance) }
  end
  def [](pos)
    @grid[pos.first][pos.last]
  end
  def []=(pos, val)
    @grid[pos.first][pos.last] = val
  end

  def show_board(message, pos=[7,0])
    display = Display.new(self, pos)
    display.display(message)
  end

  def move_piece(start_pos, end_pos, color)
    raise "Invalid position!" if check_pos(start_pos)
    raise "Invalid position!" if check_pos(end_pos)
    piece = self.grid[start_pos.first][start_pos.last]
    raise "This piece cannot move here!" unless piece.pos_moves(self).include?(end_pos)
    raise "You can't put yourself in check!" unless valid_moves(color)[piece].include?(end_pos)
    piece.pos = end_pos
    self.grid[start_pos.first][start_pos.last] = NullPiece.instance
    self.grid[end_pos.first][end_pos.last] = piece
  end

  def check_pos(pos)
    !(0..7).include?(pos.first) || !(0..7).include?(pos.last) 
  end

  def in_check?(color)
    pieces = grid.flatten.select{|piece| piece.color != color && !piece.nil?}
    pieces.any? do |piece| 
      piece.pos_moves(self).any? do |move|
        self[move].name == :king
      end
    end
  end
  
  def checkmate?(color)
    return false unless in_check?(color)
    valid_moves(color).empty?
  end

  def valid_moves(color)
    valid_moves = Hash.new{|h,k|h[k]=[]}
    pieces = grid.flatten.select{|piece| piece.color == color }
    pieces.each do |piece|
      piece.pos_moves(self).each do |move|
        board_dup = self.dup
        board_dup.dup_move(piece.pos, move, color)
        valid_moves[piece] << move unless board_dup.in_check?(color)
      end
    end
    valid_moves
  end

  def dup_move(start_pos, end_pos, color)
    piece = self.grid[start_pos.first][start_pos.last]
    piece.pos = end_pos
    self.grid[start_pos.first][start_pos.last] = NullPiece.instance
    self.grid[end_pos.first][end_pos.last] = piece
  end

  def dup
    duped = Board.new
    (0...duped.grid.length).each do |row|
      (0...duped.grid.length).each do |col|
        duped[[row, col]] = self[[row,col]].dup unless self[[row, col]].nil?
      end
    end
    duped
  end

end
