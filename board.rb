

class Board 
  attr_accessor :turn,:castle_white_long,:castle_white_short, 
                :castle_black_long,:castle_black_short, :en_passant_file

  def initialize

    @board = [Array.new(8),Array.new(8),Array.new(8),Array.new(8),
    	      Array.new(8),Array.new(8),Array.new(8),Array.new(8)
    	     ]  
    @turn = Color.white   
   
    @castle_white_long = 1        #can castle when value is 1 
    @castle_white_short = 1 
    @castle_black_long = 1
    @castle_black_short = 1 

    @en_passant_file = nil #can be zero through 7  
  end 
  

  def castle_variables_array
    [self.castle_white_long,self.castle_white_short,self.castle_black_long,self.castle_black_short]
  end 

  
  def change_turn 
    if @turn == Color.white 
      @turn = Color.black 
    else 
      @turn = Color.white
    end  
  end

  def put_piece(piece,square)    #file is horizontal , rank is vertical 
    @board[square.file.int][square.rank.int] = piece
  end 

  def read_square(square) 
    @board[square.file.int][square.rank.int]  #returns a piece or nil 
  end

  def remove_piece(square)
    @board[square.file.int][square.rank.int] = nil 
  end 

  def full_board

  
    #self.put_piece( Piece.white_rook, Square.new(File.a,Rank.one) )
    #self.put_piece( Piece.white_knight, Square.new(File.b,Rank.one) )
    #self.put_piece( Piece.white_bishop, Square.new(File.c,Rank.one) )
    #self.put_piece( Piece.white_queen, Square.new(File.d,Rank.one) )
    self.put_piece( Piece.white_king, Square.new(File.e,Rank.one) )
    self.put_piece( Piece.white_bishop, Square.new(File.f,Rank.one) )
    self.put_piece( Piece.white_knight, Square.new(File.g,Rank.one) )
    self.put_piece( Piece.white_rook, Square.new(File.h,Rank.one) )

    self.put_piece( Piece.black_rook, Square.new(File.a,Rank.eight) )
    self.put_piece( Piece.black_knight, Square.new(File.b,Rank.eight) )
    self.put_piece( Piece.black_bishop, Square.new(File.c,Rank.eight) )
    self.put_piece( Piece.black_queen, Square.new(File.d,Rank.eight) )
    self.put_piece( Piece.black_king, Square.new(File.e,Rank.eight) )
    self.put_piece( Piece.black_bishop, Square.new(File.f,Rank.eight) )
    self.put_piece( Piece.black_knight, Square.new(File.g,Rank.eight) )
    self.put_piece( Piece.black_rook, Square.new(File.h,Rank.eight) )
    
    #self.put_piece( Piece.white_pawn, Square.new(File.a,Rank.two) )
    self.put_piece( Piece.white_pawn, Square.new(File.b,Rank.two) )
    self.put_piece( Piece.white_pawn, Square.new(File.c,Rank.two) )
    self.put_piece( Piece.white_pawn, Square.new(File.d,Rank.two) )
    self.put_piece( Piece.white_pawn, Square.new(File.e,Rank.two) )
    self.put_piece( Piece.white_pawn, Square.new(File.f,Rank.two) )
    self.put_piece( Piece.white_pawn, Square.new(File.g,Rank.two) )
    self.put_piece( Piece.white_pawn, Square.new(File.h,Rank.two) )

    #self.put_piece( Piece.black_pawn, Square.new(File.a,Rank.seven) )
    self.put_piece( Piece.black_pawn, Square.new(File.b,Rank.seven) )
    self.put_piece( Piece.black_pawn, Square.new(File.c,Rank.seven) )
    self.put_piece( Piece.black_pawn, Square.new(File.d,Rank.seven) )
    self.put_piece( Piece.black_pawn, Square.new(File.e,Rank.seven) )
    self.put_piece( Piece.black_pawn, Square.new(File.f,Rank.seven) )
    self.put_piece( Piece.black_pawn, Square.new(File.g,Rank.seven) )
    self.put_piece( Piece.black_pawn, Square.new(File.h,Rank.seven) )

  end 

 



  def clone
    board = Board.new
    board.turn = self.turn  
    for file in File.values
      for rank in Rank.values 
        board.put_piece( self.read_square(Square.new(file,rank)),Square.new(file,rank) )
      end
    end
    board   
  end  
end 
 


