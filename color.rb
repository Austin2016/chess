class Color
  @@white = Color.new
  @@black = Color.new 
  
  def self.black
    @@black 
  end 


  def self.white
    @@white  
  end  
  
  def self.opposite(color) 
    if color == Color.black
      return Color.white 
    elsif color == Color.white
      return Color.black 
    end 
  end 

  def self.values 
    [Color.black,Color.white]
  end

  

end 
