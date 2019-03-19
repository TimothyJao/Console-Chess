module Slideable
  def possible_move?(board, pos)
    return false unless (0..7).include?(pos.first) && (0..7).include?(pos.last)
    return false if board[pos].color == self.color
    true
  end

  def pos_moves(board)
    moves = []
    short_moves = move_dirs
    short_moves.each do |direction|
      new_pos = pos.dup
      while true
        new_pos = [new_pos.first+direction.first, new_pos.last+direction.last]
        if possible_move?(board, new_pos)
          moves << new_pos
        else
          break
        end
        break unless board[new_pos].nil?
      end
    end
    moves
  end

  def move_dirs
    short_moves = []
    if dir.include? :straight
      short_moves += [[1,0], [0,1], [-1, 0], [0, -1]]
    end
    if dir.include? :diagonal
      short_moves += [[1,1], [1,-1], [-1, 1], [-1, -1]]
    end
    short_moves
  end
end