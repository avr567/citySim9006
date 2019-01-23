class Location
		
		
		#attributes are the location's name and whether it contains anything. Neighboring locations are also listed as well as connecting roads
		attr_accessor :name
		
		attr_accessor :contains_books
		attr_accessor :contains_toys
		attr_accessor :contains_classes
		
		attr_accessor :west_location
		attr_accessor :north_location
		attr_accessor :east_location
		attr_accessor :south_location
	
		attr_accessor :west_road
		attr_accessor :north_road
		attr_accessor :east_road
		attr_accessor :south_road
		
		def initialize name, contains_books, contains_classes, contains_toys
			
			@name = name
			@contains_books = contains_books
			@contains_classes = contains_classes
			@contains_toys = contains_toys
		
		end
		
		def set_location west_location, north_location, east_location, south_location
		
			@west_location = west_location
			@north_location = north_location
			@east_location = east_location
			@south_location = south_location
		
		
		end
		
		def set_roads west_road, north_road, east_road, south_road
		
			@west_road = west_road 
			@north_road = north_road
			@east_road = east_road
			@south_road = south_road
		
		end
		
		
	end
