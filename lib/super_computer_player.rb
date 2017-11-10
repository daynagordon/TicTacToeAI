require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    head = TicTacToeNode.new(game.board.dup, mark)
    kids = head.children
    pos = []
    non_losing_moves = []
    kids.each do |kid|
      return kid.prev_move_pos if kid.winning_node?(mark)
      non_losing_moves << kid.prev_move_pos unless kid.losing_node?(mark)
    end
    raise "Defeat is impossible" if non_losing_moves.empty?
    non_losing_moves.shuffle.first
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
