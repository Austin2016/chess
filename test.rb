class Test 
   
            

  def initialize (a)
    @a = a
  end 
  
  def a=(value)
    @a = value
  end 
  
  def a 
    @a
  end



end 


my_test = Test.new(1)

puts my_test.a
my_test.a = 3888
puts my_test.a