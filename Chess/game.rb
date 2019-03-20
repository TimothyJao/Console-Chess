require_relative "board.rb" 
class Game

  attr_accessor :board, :current_player

  def initialize
    @board = Board.create_board
    @current_player = :white
  end

  def switch_player
    if self.current_player == :white
      self.current_player = :black
    else
      self.current_player = :white
    end
  end

  def turn
    start_pos = board.show_board("#{self.current_player.capitalize} please select a piece")
    piece = board.grid[start_pos.first][start_pos.last]
    raise "This ain't a piece!" if piece.nil?
    raise "This piece is not your color!" if piece.color != self.current_player
    end_pos = board.show_board("#{self.current_player.capitalize} please select the position", start_pos)
    board.move_piece(start_pos, end_pos, self.current_player)
    switch_player
  end

  def play
    while true
      begin
        if board.checkmate?(current_player)
          switch_player
          puts "\r\n#{self.current_player.capitalize} wins"
          sleep(1)
          Process.exit(0)
        end
        if board.in_check?(current_player)        
          puts "\r\n#{self.current_player.capitalize} is in check"
          sleep(1)
        end
        turn
      rescue RuntimeError => e
        puts "\r\n"
        puts e.message
        sleep(1)
        retry
      end
    end
  end
end

game = Game.new
game.play