
class MakeMove

  def self.make_move(board,move)
    board.remove_piece(move.initial)
    board.put_piece(move.moving_piece,move.destination)   
    if move.moving_piece == Piece.white_king && move.destination_piece == Piece.white_rook
      board.put_piece(move.destination_piece,move.initial)
    end
    if move.moving_piece == Piece.black_king && move.destination_piece == Piece.black_rook
      board.put_piece(move.destination_piece,move.initial)
    end  
    MakeMove.update_castling_status(board,move)
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

end 

# psuedo_board = board.clone
#    MovesGenerator.moves_list(psuedo_board)
