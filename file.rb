class File   #a,b,c,d,e,f,g,h

 attr_reader :int 

   
  def initialize(int)
    if !int.is_a?(Integer)
      raise ArgumentError, "invalid input: not an integer"
    end
    if int < 0 || int > 7 
      raise ArgumentError, "invalid input: out of bounds"
    end 
    @int = int 
  end 


  @@a=File.new(0)
  @@b=File.new(1)
  @@c=File.new(2)
  @@d=File.new(3)
  @@e=File.new(4)
  @@f=File.new(5)
  @@g=File.new(6)
  @@h=File.new(7) 

  def self.a
    @@a
  end
    
  def self.b
    @@b
  end

  def self.c
    @@c
  end

  def self.d
    @@d
  end

  def self.e
    @@e
  end

  def self.f
    @@f
  end

  def self.g
    @@g
  end

  def self.h
    @@h
  end
   
  def self.values
    [File.a,File.b,File.c,File.d,File.e,File.f,File.g,File.h] 
    # can my class variables be modifed because of this method ? 
  end   

  


end 