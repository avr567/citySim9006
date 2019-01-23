class ArgsChecker
  def check_args arr
     raise "Please enter one seed input" unless arr.count == 1
	 
	 my_seed = arr[0]
	 
	 return Integer(my_seed) rescue return 0
	 
     
  end
end

