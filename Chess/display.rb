require_relative "cursor.rb"
require "curses"
require "colorize"

class Display
  include Curses
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([7,0], board)
  end

  def render
    
    board.grid.each_with_index do |row, idx1|
      row.each_with_index do |piece, idx2|
        if cursor.cursor_pos == [idx1, idx2]
          print to_pic(piece).colorize( :color => :black , :background => :red )
        elsif (idx1 + idx2).even?
          print to_pic(piece).colorize( :background => :white, :color => :black )
        else
          print to_pic(piece).colorize( :background => :green, :color => :black )
        end
      end
      puts 
    end
  end

  def to_pic(piece)
    return " " if piece.nil?
    case piece.color
    when "White"
      case piece.name
      when "Pawn"
        return "♙"
      when "Rook"
        return "♖"
      when "Knight"
        return "♘"
      when "Bishop"
        return "♗"
      when "Queen"
        return "♕"
      when "King"
        return "♔"
      end
    when "Black"
      case piece.name
      when "Pawn"
        return "♟"
      when "Rook"
        return "♜"
      when "Knight"
        return "♞"
      when "Bishop"
        return "♝"
      when "Queen"
        return "♛"
      when "King"
        return "♚"
      end
    end
  end
  def display
    key = nil
    while key.nil?
      # curs_set(1)
      system("clear")
      render
      # curs_set(0)
      key = cursor.get_input
    end
    p key
    key
  end
end