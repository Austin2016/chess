


class Draw


  def self.drawer(board)
    reversed_ranks = Rank.values.reverse
    files = File.values 
    for rank in reversed_ranks
      puts ""
      for file in files
        piece_i_j = board.read_square( Square.new( file,rank ) )
        if piece_i_j.is_a?(Piece)
          Draw.print_piece(piece_i_j)
        elsif piece_i_j == nil
          print "▓" if (rank.int+file.int)%2 == 0
  		  print "░" if (rank.int+file.int)%2 == 1 
        end 
      end
    end 
    puts ""
    puts ""
  end


  def self.print_piece(piece) 
  	case piece
  	when Piece.white_pawn
  		print "♙" 
  	when Piece.white_rook
  		print "♖" 
  	when Piece.white_bishop          	
  		print "♗"
  	when Piece.white_knight
  		print "♘"
  	when Piece.white_queen
  		print "♕" 
  	when Piece.white_king
  		print "♔" 
  	when Piece.black_pawn
  		print "♟"
  	when Piece.black_rook
  		print "♜"
  	when Piece.black_bishop 
  		print "♝"
  	when Piece.black_knight
  		print "♞"
  	when Piece.black_queen 
  		print "♛"
  	when Piece.black_king
  		print "♚"
  	else 
  	  return nil 
  	end
  end
end 
=begin
 "♖"	
 "♘"	
 "♗"	
 "♕"	
 "♔"	
 "♙" 
 
 "♜"
 "♞"
 "♝"
 "♛"	
 "♚"	
 "♟"	

 "░"

 "▓"

=end 

