
class Sim

require_relative 'player'
require_relative 'location'

#this class will simulate a single round
	attr_accessor :hospital
	attr_accessor :cathedral
	attr_accessor :hillman
	attr_accessor :museum
	attr_accessor :driver
	attr_accessor :prng
	attr_accessor :sim_finished
	


	def initialize driver, prng
		
		
		@driver = driver
		@prng = prng
		@sim_finished = false
		#creates the 4 locations used for the sim
		
		@hospital = Location::new "Hospital", false, false, false
		@cathedral = Location::new "Cathedral", false, true, false
		@hillman = Location::new "Hillman", true, false, false
		@museum = Location::new "Museum", false, false, true
		
		#sets the neighbors of each location
		hospital.set_location nil, nil, cathedral, hillman
		cathedral.set_location hospital, nil, nil, museum
		museum.set_location hillman, cathedral, nil, nil
		hillman.set_location nil, hospital, museum, nil
		
		#sets the roads connected to each location
		hospital.set_roads nil, nil, "Fourth Ave", "Foo St"
		cathedral.set_roads nil, nil, nil, "Bar St"
		museum.set_roads "Fifth Ave", "Bar St", nil, nil
		hillman.set_roads nil, "Foo St", nil, nil
		
	end
	#initial driver location
	def set_driver_location_initial
		loc_position = prng.rand(4)
		if loc_position == 0
			driver.location = hospital
			return driver.location
		elsif loc_position == 1
			driver.location = cathedral
			return driver.location
		elsif loc_position == 2
			driver.location = hillman
			return driver.location
		elsif loc_position == 3
			driver.location = museum
			return driver.location
		else
			raise "The seed is not 0 1 2 3"
		end

	end
	#potential new position of the driver
	def get_new_position
		loc_position = prng.rand(4)
		return loc_position

	end
	#one iteration printed when the driver has moved
	def print_iteration via_road, to_move
		prev_location = ""
		if to_move == 0
			prev_location = driver.location.east_location
		elsif to_move == 1
			prev_location = driver.location.south_location
		elsif to_move == 2
			prev_location = driver.location.west_location
		elsif to_move == 3
			prev_location = driver.location.north_location
		end
		puts "#{driver.name} heading from #{prev_location.name} to #{driver.location.name} via #{via_road}."
	end
	#increase books, toys or classes if the driver has moved to a relevent location
	def increase_count first_loc
		if first_loc.contains_toys != false
			driver.num_toys += 1
			return driver.num_toys
		elsif first_loc.contains_books != false
			driver.num_books += 1
			return driver.num_books
		elsif first_loc.contains_classes != false
			driver.num_classes *= 2
			return driver.num_classes
		end
	
	end
	#print final count of each item
	def print_final_count finished_driver
		if finished_driver.num_books == 1
			puts "#{finished_driver.name} obtained #{finished_driver.num_books} book!"
		else
			puts "#{finished_driver.name} obtained #{finished_driver.num_books} books!"
		end
		
		if finished_driver.num_toys == 1
			puts "#{finished_driver.name} obtained #{finished_driver.num_toys} dinosaur toy!"
		else
			puts "#{finished_driver.name} obtained #{finished_driver.num_toys} dinosaur toys!"
		end
		
		if finished_driver.num_classes == 1
			puts "#{finished_driver.name} attended #{finished_driver.num_classes} class!"
		else
			puts "#{finished_driver.name} attended #{finished_driver.num_classes} classes!"
		end
		
	end
	#see if driver is leaving to downtown or monroeville
	def check_for_leaving curr_loc, to_move
		if curr_loc.name == "Cathedral" and to_move == 2
			puts "#{driver.name} heading from #{driver.location.name} to Monroeville via Fourth Ave."
			@sim_finished = true
			return true
		elsif curr_loc.name == "Hillman" and to_move == 0
			puts "#{driver.name} heading from #{driver.location.name} to Downtown via Fifth Ave."
			@sim_finished = true
			return true
		end
		return false
	end
	#check to see if a potential move is valid
	def check_valid_move to_move
		
		if to_move == 0
			if  driver.location.west_road == nil
				return false
			else
				return true
			end
		
		elsif to_move == 1
			if  driver.location.north_road == nil
				return false
			else
				return true
			end
		
		elsif to_move == 2
			if  driver.location.east_road == nil
				return false
			else
				return true
			end
		
		elsif to_move == 3
			if  driver.location.south_road == nil
				return false
			else
				return true
			end
		else
			raise "The location does not exist. Error"
		
		end
		return false
	end
	#move driver to new location
	def move to_move
		if to_move == 0
			via_road = driver.location.west_road
			driver.location = driver.location.west_location
			return via_road
		elsif to_move == 1
			via_road = driver.location.north_road
			driver.location = driver.location.north_location
			return via_road
		elsif to_move == 2
			via_road = driver.location.east_road
			driver.location = driver.location.east_location
			return via_road
		elsif to_move == 3
			via_road = driver.location.south_road
			driver.location = driver.location.south_location
			return via_road
		end
		
	end
	#get the current location of the driver
	def get_current_loc
		return driver.location
	end
		
end