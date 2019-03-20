require_relative "piece.rb"
require_relative "stepable.rb"
require "byebug"

class King < Piece

  include Stepable
  attr_accessor :moved
  def initialize(name, pos, color)
    super
    @moved = false
    if @color == :black
      @symbol = " ♚ "
    else
      @symbol = " ♔ "
    end
  end
  def castle(board, end_pos, color)
    return false if self.moved
    possible_positions = [[self.pos.first, self.pos.last + 2], [self.pos.first, self.pos.last - 2]]
    return false unless possible_positions.include?(end_pos)
    if end_pos.last == self.pos.last + 2
      rook = board[[end_pos.first, 7]]
      return false unless rook.name == :rook
      return false if rook.moved
      return false unless board[[end_pos.first, 5]].nil? && board[[end_pos.first, 6]].nil?
      
      pieces = board.grid.flatten.select{|piece| piece.color != color && !piece.nil?}
      pieces.each do |piece| 
        piece.pos_moves(board).each do |move|
          return false if move == [end_pos.first, 6] || move == [end_pos.first, 5]
        end
      end
    elsif end_pos.last == self.pos.last - 2
      rook = board[[end_pos.first, 0]]
      return false unless rook.name == :rook
      return false if rook.moved
      return false unless board[[end_pos.first, 3]].nil? && board[[end_pos.first, 2]].nil?
      pieces = board.grid.flatten.select{|piece| piece.color != color && !piece.nil?}
      pieces.each do |piece| 
        piece.pos_moves(board).each do |move|
          return false if move == [end_pos.first, 3] || move == [end_pos.first, 2]
        end
      end
    end
  true
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