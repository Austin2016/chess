class Piece
  
  attr_reader :type, :color

  def initialize(type,color)
    if !type.is_a?(PieceType)
      raise ArgumentError, "invalid input: not a piece type"
    end 
    if !color.is_a?(Color)
      raise ArgumentError, "invalid input: not a valid color"
    end
    @type = type  
    @color = color 
  end 

  def self.white_pawn
    Piece.new(PieceType.pawn,Color.white)
  end 

  def self.white_rook
    Piece.new(PieceType.rook,Color.white)
  end 

  def self.white_bishop
    Piece.new(PieceType.bishop,Color.white)
  end 

  def self.white_knight
    Piece.new(PieceType.knight,Color.white)
  end 

  def self.white_queen
    Piece.new(PieceType.queen,Color.white)
  end 

  def self.white_king
    Piece.new(PieceType.king,Color.white)
  end 

  def self.black_pawn
    Piece.new(PieceType.pawn,Color.black)
  end 

  def self.black_rook
    Piece.new(PieceType.rook,Color.black)
  end 

  def self.black_bishop
    Piece.new(PieceType.bishop,Color.black)
  end 

  def self.black_knight
    Piece.new(PieceType.knight,Color.black)
  end 

  def self.black_queen
    Piece.new(PieceType.queen,Color.black)
  end 

  def self.black_king
    Piece.new(PieceType.king,Color.black)
  end 

  def ==(other)
    return nil if other == nil 
    if self.type == other.type && self.color == other.color
      return true
    else 
      return false
    end 
  end 

  

end 



