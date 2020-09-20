

class Square
 
  attr_reader :file, :rank 
  
  def initialize(file,rank) #file is horizontal 
    if !file.is_a?(File)
      raise ArgumentError, "invalid input: not a file"
    end 

    if !rank.is_a?(Rank)
      raise ArgumentError, "invalid input: not a rank"
    end 
    @file = file
    @rank = rank 
    
  end

  def ==(other)
    return nil if other == nil 
    if self.file == other.file && self.rank == other.rank
      return true
    else 
      return false
    end 
  end 



end 



