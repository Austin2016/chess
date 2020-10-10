
class Dialogue 


  def self.prompt(board)
    puts "#{Color.to_s(board.turn)}, it's your turn!"
    user_entry = gets.chomp 
    user_entry 
  end 
   




end 
