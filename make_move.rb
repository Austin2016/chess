
class MakeMove

  def self.make_move(board,move)
    board.remove_piece(move.initial)
    board.put_piece(move.moving_piece,move.destination)   
    if move.is_castle_move? && move.moving_piece.color == Color.white && move.destination.file == File.c
      board.put_piece(Piece.white_rook,Square.new(File.d,Rank.one))
      board.remove_piece(Square.new(File.a,Rank.one))
    elsif move.is_castle_move? && move.moving_piece.color == Color.black && move.destination.file == File.c
      board.put_piece(Piece.black_rook,Square.new(File.d,Rank.eight))
      board.remove_piece(Square.new(File.a,Rank.eight))
    elsif move.is_castle_move? && move.moving_piece.color == Color.white && move.destination.file == File.g
      board.put_piece(Piece.white_rook,Square.new(File.f,Rank.one))
      board.remove_piece(Square.new(File.h,Rank.one))
    elsif move.is_castle_move? && move.moving_piece.color == Color.black && move.destination.file == File.g
      board.put_piece(Piece.black_rook,Square.new(File.f,Rank.eight))
      board.remove_piece(Square.new(File.h,Rank.eight))
    end 

    if move.is_en_passant?
      board.put_piece(move.moving_piece,move.destination)
      board.remove_piece( MovesGenerator.square_behind_a_piece(move.destination,move.moving_piece,board) )
    end

    if move.is_promotion?
      board.put_piece(move.promotion,move.destination)
    end  

    MakeMove.update_castling_status(board,move)
    MakeMove.update_en_passant_status(board,move) 
    board.change_turn 
  end

  

private 

  

  def self.update_castling_status(board,move)
    if move.initial == Square.new(File.a,Rank.one) || move.destination == Square.new(File.a,Rank.one)
      board.castle_white_long = 0
    elsif move.initial == Square.new(File.h,Rank.one) || move.destination == Square.new(File.h,Rank.one)
      board.castle_white_short = 0 
    end
    if move.initial == Square.new(File.e,Rank.one)
      board.castle_white_long = 0  
      board.castle_white_short = 0
    end 

    if move.initial == Square.new(File.a,Rank.eight) || move.destination == Square.new(File.a,Rank.eight)
      board.castle_black_long = 0
    elsif move.initial == Square.new(File.h,Rank.eight) || move.destination == Square.new(File.h,Rank.eight)
      board.castle_black_short = 0 
    end
    if move.initial == Square.new(File.e,Rank.eight)
      board.castle_black_long = 0  
      board.castle_black_short = 0
    end
  end   

  def self.update_en_passant_status(board,move)
    if move.moving_piece.type == PieceType.pawn && (move.initial.rank.int - move.destination.rank.int).abs > 1 
      board.en_passant_file = move.destination.file.int
    else 
      board.en_passant_file = nil 
    end 
  end  

end 

