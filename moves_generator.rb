class MovesGenerator 
  
  KNIGHT_DELTAS = [ [1,2],[2,1],[1,-2],[2,-1],[-1,2],[-2,1],[-1,-2],[-2,-1] ]

  BISHOP_DELTAS = [ [ [1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7] ],
                    [ [1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7] ],
                    [ [-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7] ],
                    [ [-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7] ]
                    
                  ]
  ROOK_DELTAS =   [ [ [0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7] ], 
               		[ [0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7] ], 
               		[ [-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0] ], 
               		[ [1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0] ],
                  ]

  QUEEN_DELTAS =  BISHOP_DELTAS + ROOK_DELTAS 

  KING_DELTAS = [ [1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  
  WHITE_PAWN_MOVE_DELTAS = [  [0,1],[0,2]  ]

  WHITE_PAWN_ATTACK_DELTAS = [ [-1,1],[1,1]  ]

  BLACK_PAWN_MOVE_DELTAS = [ [0,-1],[0,-2] ]

  BLACK_PAWN_ATTACK_DELTAS = [ [-1,-1],[1,-1] ]

  CASTLE_DELTA_LONG =  [-4,0] 

  CASTLE_DELTA_SHORT =  [3,0]



  def self.moves_list(board) 
    moves = []
    turn = board.turn 
    for rank in Rank.values 
      for file in File.values 
        piece = board.read_square( Square.new(file,rank) )
        if piece != nil && piece.color == turn 
          case piece 
          when Piece.white_knight  
            MovesGenerator.knight_moves( Square.new(file,rank), Piece.white_knight, board ).each {|e| moves << e }       
          when Piece.black_knight
            MovesGenerator.knight_moves( Square.new(file,rank), Piece.black_knight, board ).each {|e| moves << e }
          when Piece.white_bishop
            MovesGenerator.bishop_moves( Square.new(file,rank), Piece.white_bishop, board ).each {|e| moves << e }
          when Piece.black_bishop
            MovesGenerator.bishop_moves( Square.new(file,rank), Piece.black_bishop, board ).each {|e| moves << e }  
          when Piece.white_rook
            MovesGenerator.rook_moves( Square.new(file,rank), Piece.white_rook, board ).each {|e| moves << e }
          when Piece.black_rook
            MovesGenerator.rook_moves( Square.new(file,rank), Piece.black_rook, board ).each {|e| moves << e }
          when Piece.white_queen
            MovesGenerator.queen_moves( Square.new(file,rank), Piece.white_queen, board ).each {|e| moves << e }
          when Piece.black_queen
            MovesGenerator.queen_moves( Square.new(file,rank), Piece.black_queen, board ).each {|e| moves << e } 
          when Piece.white_king
            MovesGenerator.king_moves( Square.new(file,rank), Piece.white_king, board ).each {|e| moves << e }
          when Piece.black_king
            MovesGenerator.king_moves( Square.new(file,rank), Piece.black_king, board ).each {|e| moves << e }
          when Piece.white_pawn
            MovesGenerator.pawn_moves( Square.new(file,rank), Piece.white_pawn, board ).each {|e| moves << e }
          when Piece.black_pawn
            MovesGenerator.pawn_moves( Square.new(file,rank), Piece.black_pawn, board ).each {|e| moves << e }    
          else
          end 
        end 
      end 
    end 
    moves
  end

  def self.legal_moves_list(board)
    moves_list = MovesGenerator.moves_list(board) 
    puts moves_list.length 
  	for move in moves_list	
      board_clone = board.clone
      MakeMove.make_move(board_clone,move)
      board_clone.change_turn #added for readability, doesn't matter 
      king_square = MovesGenerator.find_king(board_clone,board.turn)
      if MovesGenerator.is_square_attacked?(king_square,board_clone,board_clone.turn)
        moves_list.delete(move)
      end 
      if self.is_castle_move?(move) && move.destination.file == File.h && move.moving_piece == Piece.white_king
      	white_short_path = [Square.new(File.f,Rank.one),Square.new(File.g,Rank.one)]
        white_short_path.each do |square| 
      	  if MovesGenerator.is_square_attacked?(square,board,board.turn) 
      	    moves_list.delete(move)
      	    break
      	  end 
        end 
      end
      if self.is_castle_move?(move) && move.destination.file == File.a && move.moving_piece == Piece.white_king
      	white_long_path = [Square.new(File.d,Rank.one),Square.new(File.c,Rank.one),Square.new(File.b,Rank.one)]    				           				       
        white_long_path.each do |square| 
      	  if MovesGenerator.is_square_attacked?(square,board,board.turn) 
      	    moves_list.delete(move)
      	    break
      	  end 
        end 
      end
      if self.is_castle_move?(move) && move.destination.file == File.h && move.moving_piece == Piece.black_king
      	white_short_path = [Square.new(File.f,Rank.one),Square.new(File.g,Rank.one)]    					                                
        white_short_path.each do |square| 
      	  if MovesGenerator.is_square_attacked?(square,board,board.turn) 
      	    moves_list.delete(move)
      	    break
      	  end 
        end 
      end
      if self.is_castle_move?(move) && move.destination.file == File.a && move.moving_piece == Piece.black_king
      	white_short_path = [Square.new(File.d,Rank.one),Square.new(File.c,Rank.one),Square.new(File.b,Rank.one)]    					                              
        white_short_path.each do |square| 
      	  if MovesGenerator.is_square_attacked?(square,board,board.turn) 
      	    moves_list.delete(move)
      	    break
      	  end 
        end 
      end 
    end 
    moves_list  
  end

  def self.is_castle_move?(move) 
    (move.moving_piece == Piece.black_king || move.moving_piece == Piece.white_king) && (move.destination.file.int - move.initial.file.int).abs > 1 
  end    

  def self.find_king(board,color)
    target_piece = Piece.black_king if color == Color.black
    target_piece = Piece.white_king if color == Color.white  
    for file in File.values
      for rank in Rank.values
      	target_square = Square.new(file,rank)
        piece = board.read_square( target_square )
        return target_square if piece == target_piece 
      end 
    end 
  end 
      


  def self.is_square_attacked?(square,board,attacking_color) 
    attacked_color = Color.opposite(attacking_color)
    if MovesGenerator.knight_moves(square,Piece.new(PieceType.knight,attacked_color),board).any? do |move| 
         move.destination_piece == Piece.new(PieceType.knight,attacking_color) 
       end
       return true  
    end
    if MovesGenerator.king_moves(square,Piece.new(PieceType.king,attacked_color),board).any? do |move| 
         move.destination_piece == Piece.new(PieceType.king,attacking_color) 
       end
       return true  
    end
    if MovesGenerator.bishop_moves(square,Piece.new(PieceType.bishop,attacked_color),board).any? do |move| 
         move.destination_piece == Piece.new(PieceType.bishop,attacking_color) 
       end
       return true  
    end
    if MovesGenerator.rook_moves(square,Piece.new(PieceType.rook,attacked_color),board).any? do |move| 
         move.destination_piece == Piece.new(PieceType.rook,attacking_color) 
       end
       return true  
    end
    if MovesGenerator.queen_moves(square,Piece.new(PieceType.queen,attacked_color),board).any? do |move| 
         move.destination_piece == Piece.new(PieceType.queen,attacking_color) 
       end
       return true  
    end
    if MovesGenerator.pawn_moves(square,Piece.new(PieceType.pawn,attacked_color),board).any? do |move| 
         move.destination_piece == Piece.new(PieceType.pawn,attacking_color) 
       end
       return true  
    end     
    false 
  end
  

  def self.king_castle_moves_list(piece,board) 
    int_array = [] 
    init_white = [4,0]
    init_black = [4,7]
    black_short_path = [ board.read_square( Square.new(File.f,Rank.eight) ),
    					 board.read_square( Square.new(File.g,Rank.eight) )
    				   ] 
    
    black_long_path = [ board.read_square( Square.new(File.d,Rank.eight) ),
    					board.read_square( Square.new(File.c,Rank.eight) ),
    					board.read_square( Square.new(File.b,Rank.eight) ) 
    			      ]

    white_short_path = [ board.read_square( Square.new(File.f,Rank.one) ),
    					 board.read_square( Square.new(File.g,Rank.one) )
                       ]
    
    white_long_path = [ board.read_square( Square.new(File.d,Rank.one) ),
    				     board.read_square( Square.new(File.c,Rank.one) ),
    				     board.read_square( Square.new(File.b,Rank.one) )
    				   ] 

    if piece == Piece.black_king && board.castle_black_short == 1 && black_short_path.all? {|e| e == nil}
        int_array <<  MovesGenerator.vector_addition(CASTLE_DELTA_SHORT,init_black)
    end
    if piece == Piece.black_king && board.castle_black_long == 1 && black_long_path.all? {|e| e == nil}
        int_array <<  MovesGenerator.vector_addition(CASTLE_DELTA_LONG,init_black)
    end      
    if piece == Piece.white_king && board.castle_white_short == 1 && white_short_path.all? {|e| e == nil}
      int_array <<  MovesGenerator.vector_addition(CASTLE_DELTA_SHORT,init_white)
    end
    if piece == Piece.white_king && board.castle_white_long == 1 && white_long_path.all? {|e| e == nil}
      int_array <<  MovesGenerator.vector_addition(CASTLE_DELTA_LONG,init_white)
    end 
    int_array 
  end
 



  def self.knight_moves(initial_square,piece,board)
    init = [initial_square.file.int,initial_square.rank.int]
    int_array = []
    moves_array = []  
    for delta in KNIGHT_DELTAS 
      int_array <<  MovesGenerator.vector_addition(delta,init) 
    end  
    int_array.select! {|e| e[0] >= 0 && e[0] <= 7 && e[1] >=0 && e[1] <=7 }
    int_array.select! do |e| 
      read_piece = board.read_square( Square.new( File.values[e[0]],Rank.values[e[1]]) )
      read_piece == nil || read_piece.color != piece.color    
    end  
    int_array.each do |e|
      destination = Square.new(File.values[e[0]],Rank.values[e[1]]) 
      moves_array << Moves.new(initial_square, destination, piece, board.read_square(destination))   
    end
    moves_array 
  end

  def self.bishop_moves(initial_square,piece,board)
    MovesGenerator.sliding_piece_moves(initial_square,piece,board)
  end

  def self.rook_moves(initial_square,piece,board)
    MovesGenerator.sliding_piece_moves(initial_square,piece,board)
  end

  def self.queen_moves(initial_square,piece,board)
    MovesGenerator.sliding_piece_moves(initial_square,piece,board)
  end

  def self.sliding_piece_moves(initial_square,piece,board)
    init = [initial_square.file.int,initial_square.rank.int]
    int_array = []
    moves_array = []
    if piece == Piece.white_rook || piece == Piece.black_rook
      deltas = ROOK_DELTAS
    elsif piece == Piece.white_bishop || piece == Piece.black_bishop
      deltas = BISHOP_DELTAS
    elsif piece == Piece.white_queen || piece == Piece.black_queen 
      deltas = QUEEN_DELTAS
    end 
    for vector in deltas
      for delta in vector
      	file_values_index = MovesGenerator.vector_addition(delta,init)[0]
      	rank_values_index = MovesGenerator.vector_addition(delta,init)[1]
        if file_values_index >= 0 && file_values_index <= 7 && rank_values_index >= 0 && rank_values_index <= 7 
          int_array <<  MovesGenerator.vector_addition(delta,init)
          break if board.read_square( Square.new( File.values[file_values_index],Rank.values[rank_values_index] ) ) != nil  
        end 
      end 
    end  
    int_array.select! {|e| e[0] >= 0 && e[0] <= 7 && e[1] >=0 && e[1] <=7 }
   
    int_array.select! do |e| 
      read_piece = board.read_square( Square.new( File.values[e[0]],Rank.values[e[1]]) )
      read_piece == nil || read_piece.color != piece.color    
    end  
    
    int_array.each do |e|
      destination = Square.new(File.values[e[0]],Rank.values[e[1]]) 
      moves_array << Moves.new( initial_square,destination,piece,board.read_square(destination) ) 
    end 
    moves_array 
  end

  def self.king_moves(initial_square,piece,board)
    init = [initial_square.file.int,initial_square.rank.int]
    int_array = []
    moves_array = []  
    for delta in KING_DELTAS
      int_array <<  MovesGenerator.vector_addition(delta,init) 
    end

    

    int_array.select! {|e| e[0] >= 0 && e[0] <= 7 && e[1] >=0 && e[1] <=7 }
    int_array.select! do |e| 
      read_piece = board.read_square( Square.new( File.values[e[0]],Rank.values[e[1]]) )
      read_piece == nil || read_piece.color != piece.color    
    end 
    
    int_array += self.king_castle_moves_list(piece,board) 
     
    int_array.each do |e| 
      destination = Square.new(File.values[e[0]],Rank.values[e[1]])
      moves_array << Moves.new(initial_square, destination, piece, board.read_square(destination) ) 
    end
    moves_array 
  end
  
  def self.pawn_moves(initial_square,piece,board)
    init = [initial_square.file.int,initial_square.rank.int]
    int_array_move = []
    int_array_attack = []
    moves_array = [] 
    if piece == Piece.black_pawn
      move_deltas = []  
      move_deltas << BLACK_PAWN_MOVE_DELTAS[0]
      move_deltas << BLACK_PAWN_MOVE_DELTAS[1]
      move_deltas.pop if initial_square.rank != Rank.seven
      attack_deltas = BLACK_PAWN_ATTACK_DELTAS
    elsif piece == Piece.white_pawn
      move_deltas = []
      move_deltas << WHITE_PAWN_MOVE_DELTAS[0]
      move_deltas << WHITE_PAWN_MOVE_DELTAS[1]
      move_deltas.pop if initial_square.rank != Rank.two
      attack_deltas = WHITE_PAWN_ATTACK_DELTAS
    end   
    for move in move_deltas
      int_array_move <<  MovesGenerator.vector_addition(move,init) 
    end
    for attack in attack_deltas
      int_array_attack <<  MovesGenerator.vector_addition(attack,init) 
    end  
    int_array_attack.select! {|e| e[0] >= 0 && e[0] <= 7 && e[1] >=0 && e[1] <=7 } #file moves can't get off board so no need to check 
    int_array_attack.select! do |e| 
      read_piece = board.read_square( Square.new( File.values[e[0]],Rank.values[e[1]]) )
      enemy_piece = MovesGenerator.enemy_piece_behind_a_piece( Square.new( File.values[e[0]],Rank.values[e[1]]), piece, board) 
      (read_piece != nil && read_piece.color != piece.color) || ( board.en_passant_file != nil &&  (board.en_passant_file - init[0]).abs == 1 && enemy_piece != nil && enemy_piece.type == PieceType.pawn)  #condition for selecting!
    end 
    int_array_move.select! {|e| board.read_square( Square.new( File.values[e[0]],Rank.values[e[1]]) ) == nil}
    int_array_move.each do |e|
      destination = Square.new(File.values[e[0]],Rank.values[e[1]]) 
      moves_array << Moves.new( initial_square,destination,piece,board.read_square(destination) ) 
    end
    int_array_attack.each do |e|
      destination = Square.new(File.values[e[0]],Rank.values[e[1]])  
      moves_array << Moves.new( initial_square, destination, piece, board.read_square(destination) ) 
    end
    moves_array 
  end

  def self.enemy_piece_behind_a_piece(square,piece,board)
    return nil if piece.color == Color.white && square.rank == Rank.one
    return nil if piece.color == Color.black && square.rank == Rank.eight 
    if piece.color == Color.white
      behind_piece = board.read_square( Square.new(square.file, Rank.values[Rank.values.index(square.rank) - 1]) )
    elsif piece.color == Color.black 
      behind_piece = board.read_square( Square.new(square.file, Rank.values[Rank.values.index(square.rank) + 1]) )
    end 
    if behind_piece != nil && behind_piece.color == piece.color 
      return nil 
    else 
      return behind_piece 
    end 
  end 

  def self.vector_addition (a,b)
    if !a.is_a?(Array) || !b.is_a?(Array)
      raise ArgumentError, "invalid input: not an Array"
    elsif a.length != b.length 
      raise ArgumentError, "invalid input: length's don't match"
    elsif !a.all? {|e| e.is_a?(Integer)}
      raise ArgumentError, "invalid input: not all integers"
    elsif !b.all? {|e| e.is_a?(Integer)}
      raise ArgumentError, "invalid input: not all integers"
    else
      c = [] 
      for i in 0..a.length - 1
        c[i] = a[i] + b[i]
      end 
    end
    c
  end 

end 




