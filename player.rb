class Player
		#attributes are the player's name and the number of toys, books and classes the player has or has visited. The location is the current location of the player
		attr_accessor :name
		attr_accessor :num_toys
		attr_accessor :num_books
		attr_accessor :num_classes
		attr_accessor :location
		
		def initialize name
			@name = name
			@num_toys = 0
			@num_books = 0
			@num_classes = 1
		
		end
		
		

	end