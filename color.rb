class Color
  @@white = Color.new
  @@black = Color.new 
  
  def self.black
    @@black 
  end 


  def self.white
    @@white  
  end

  def self.what_color(color)
    return @@white if Color.white == color 
    return @@black if Color.black == color 
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

  def self.to_string(color) 
    print "black" if Color.what_color(color) == Color.black
    print "white" if Color.what_color(color) == Color.white 

  end 

end 
