require_relative "cursor.rb"
require "curses"
require "colorize"

class Display
  include Curses
  attr_reader :board, :cursor
  def initialize(board, pos=[7,0])
    @board = board
    @cursor = Cursor.new(pos, board)
  end

  def render
    board.grid.each_with_index do |row, idx1|
      row.each_with_index do |piece, idx2|
        if cursor.cursor_pos == [idx1, idx2]
          print piece.symbol.colorize( :color => :black , :background => :red )
        elsif (idx1 + idx2).even?
          print piece.symbol.colorize( :background => :white, :color => :black )
        else
          print piece.symbol.colorize( :background => :green, :color => :black )
        end
      end
      puts "\r\n"
    end
  end

  def display(message)
    key = nil
    curs_set(0)
    while key.nil?
      system("clear")
      render
      puts message
      key = cursor.get_input
    end
    key
  end
end