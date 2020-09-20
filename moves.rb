
class Moves
  attr_reader :initial, :destination, :moving_piece, :destination_piece
  def initialize(initial_square,destination_square,moving_piece,destination_piece=nil)
    @initial = initial_square
    @destination = destination_square
    @moving_piece = moving_piece
    @destination_piece = destination_piece     
  end


  def ==(other)
    return nil if other == nil 
    if self.initial == other.initial && 
       self.destination == other.destination && 
       self.moving_piece == other.moving_piece && 
       self.destination_piece == other.destination_piece
    then 
      return true
    else 
      return false
    end 
  end 


end 