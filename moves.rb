
class Moves
  attr_reader :initial, :destination, :moving_piece, :destination_piece, :promotion
  def initialize(initial_square,destination_square,moving_piece,destination_piece=nil, promotion=nil)
    @initial = initial_square
    @destination = destination_square
    @moving_piece = moving_piece
    @destination_piece = destination_piece  
    @promotion = promotion    
  end
  
  def is_promotion?
    self.promotion != nil 
  end 


  def is_castle_move?
    (self.moving_piece == Piece.white_king || self.moving_piece == Piece.black_king) && (self.destination.file.int - self.initial.file.int).abs > 1 
  end  

  def is_en_passant? 
    (self.moving_piece == Piece.black_pawn || self.moving_piece == Piece.white_pawn) && (self.destination.file.int - self.initial.file.int).abs == 1 && self.destination_piece == nil
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