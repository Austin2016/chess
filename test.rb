class Test 
              

  def initialize (a)
    @a = a
  end 

  
  def a
    @a
  end 



end 


my_test = Test.new(1)

x = my_test.a
y = my_test.a 


puts y
puts x 


=begin
my_test = Test.new([1,2,3])

x = my_test.a
y = my_test.a 
y[0] = 1000000    #this affects x and y 
y = y + [10000]   # this only affects y 

print y
puts "" 
print x 
puts "" 
=end