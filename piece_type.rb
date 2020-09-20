class PieceType
  @@pawn = PieceType.new 
  @@knight = PieceType.new
  @@bishop = PieceType.new
  @@rook = PieceType.new
  @@queen = PieceType.new
  @@king = PieceType.new
  
  def self.pawn
    @@pawn
  end

  def self.knight
    @@knight 
  end 

  def self.bishop
    @@bishop
  end

  def self.rook 
    @@rook
  end 
    
  def self.queen 
    @@queen
  end 
    
  def self.king
    @@king 
  end 
   
  def self.values
    [PieceType.pawn,PieceType.knight,PieceType.bishop,PieceType.rook,
     PieceType.queen,PieceType.king]
  end

end 