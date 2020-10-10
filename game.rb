require './draw.rb'
require './piece_type.rb'
require './piece.rb'
require './square.rb'
require './color.rb'
require './File.rb'
require './Rank.rb'
require './Moves.rb'
require './Moves_generator.rb'
require './make_move.rb'
require './dialogue.rb'
require './board.rb'


class Game 
 
  attr_reader :board  

  def initialize
  	@board = Board.new
  	@board.full_board
  end 


  def is_game_over? 
    return true if MovesGenerator.legal_moves_list(@board).length == 0 
    false   
  end 


  def winner
    if MovesGenerator.is_in_check?(@board,@board.turn)  
      puts Color.to_s( Color.opposite(@board.turn) ) + " wins!" 
    else 
      puts "it's a draw!"  
    end 

  end 


  def process_player_input
  	input = Dialogue.prompt(@board)
    array = MovesGenerator.legal_moves_list(@board)
    
    array.each do |move| 
      MakeMove.make_move(@board,move) if move.to_s == input        
    end 
  end 
  
  def ui 
    Draw.drawer(@board)
  end
  

end

game = Game.new
game.ui
while !game.is_game_over? 
  game.process_player_input
  game.ui
end
game.winner 

=begin
board = Board.new
board.full_board
Draw.drawer(board)
puts MovesGenerator.legal_moves_list(board).length
=end
