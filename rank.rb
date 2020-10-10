class Rank #1,2,3,4,5,6,7,8

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


  @@one=Rank.new(0)
  @@two=Rank.new(1)
  @@three=Rank.new(2)
  @@four=Rank.new(3)
  @@five=Rank.new(4)
  @@six=Rank.new(5)
  @@seven=Rank.new(6)
  @@eight=Rank.new(7) 

  def self.one
    @@one
  end
    
  def self.two
    @@two
  end

  def self.three
    @@three
  end

  def self.four
    @@four
  end

  def self.five
    @@five
  end

  def self.six
    @@six
  end

  def self.seven
    @@seven
  end

  def self.eight
    @@eight
  end

  def self.values
    [Rank.one,Rank.two,Rank.three,Rank.four,Rank.five,Rank.six,Rank.seven,Rank.eight]
  end 

  def to_s
    rank = self.int + 1 
    rank.to_s 
  end

end