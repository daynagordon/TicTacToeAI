require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    winner = @board.winner
    
    if @board.over?
      return true if winner == switch_mark(evaluator)
      return false if winner == evaluator || winner.nil?
    end
    
    kids = self.children
    
    if evaluator == @next_mover_mark
      kids.all?{ |child| child.losing_node?(evaluator) }
    else
      kids.any?{ |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    winner = @board.winner
    
    if @board.over?
      return true if winner == evaluator
      return false if winner == switch_mark(evaluator) || winner.nil?
    end
    
    kids = self.children
    
    if evaluator == @next_mover_mark
      kids.any?{ |child| child.winning_node?(evaluator) }
    else
      kids.all?{ |child| child.winning_node?(evaluator) }
    end
  end
  
  def switch_mark mark
    (mark == :x ? :o : :x)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    
    (0...3).each do |i|
      (0...3).each do |j|
        pos = [i,j]
        duped_board = @board.dup
        
        next unless duped_board.empty?(pos)
        
        duped_board[pos] = @next_mover_mark
        children <<  TicTacToeNode.new(duped_board, switch_mark( @next_mover_mark), pos)
      end
    end
    children
  end
end
