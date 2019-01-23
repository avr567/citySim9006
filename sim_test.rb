require 'minitest/autorun'
require_relative 'player'
require_relative 'location'
require_relative 'sim'

class SimTest < Minitest::Test




	def setup
		@prng = Random::new 5
		@driver1 = Player::new "test_driver"
		@my_sim = Sim::new @driver1, @prng
	end
	
	#test that we are creating an instance of a Sim object
	def test_my_sim_is_my_sim
		 assert @my_sim.is_a?(Sim)
	end
	
	
	#unit test for get_new_position
	#should return either one of the following integers: 0, 1, 2, 3
	#there are no parameters so no additional test needed
	
	def test_get_new_position
		assert_includes [0, 1, 2, 3], @my_sim.get_new_position
	end


	#unit test for print_iteration via_road, to_move
	#should print the appropriate message "test_driver heading from Museum to Hillman via Fifth Ave." after an iteration
	#will print the out of each iteration depending on the street entered and the location
	def test_print_iteration
		@my_sim.driver.location = @my_sim.hillman
		assert_output(/test_driver heading from Museum to Hillman via Fifth Ave./) {@my_sim.print_iteration("Fifth Ave.", 0)}
	end

	#unit tests for increase_count
	#test to see if increasing the count of books by 1 will occure when the driver visits hillman library
	#the number of books should increase after calling the method increase_count from 2 to 3
	#mock object that is stubbed is created for the parameters
	#sucessful increase in count -> return the new total
	#no inrease in count -> return nil
	def test_increase_count_books
		fake_location = Minitest::Mock::new "test_location"
		def fake_location.contains_books; true; end
		def fake_location.contains_toys; false; end
		def fake_location.contains_classes; false; end
		@my_sim.driver.num_books = 2
		assert_equal 3, @my_sim.increase_count(fake_location)
	end
	
	#test to see if doubling off the number of classes a driver has taken when they visit the cathedral.
	#the number of classes should increase from 2 to 4 after calling the method increase count
	#mock object that is stubbed is created for the parameters
	def test_increase_count_classes
		fake_location = Minitest::Mock::new "test_location"
		def fake_location.contains_books; false; end
		def fake_location.contains_toys; false; end
		def fake_location.contains_classes; true; end
		@my_sim.driver.num_classes = 2
		assert_equal 4, @my_sim.increase_count(fake_location)
	end
	
	#unit tests for the check_for_leaving to_move method
	#this test will check to see if the current iteration is attempting to leave the map via Monroeville or Downtown
	#If the current iteration is attempting to leave, then check_for_leaving will return true
	#mock object created for location
	#sucessful leave -> true
	#unsuccesful leave -> false
	def test_check_for_leaving_to_move_true
		fake_location = Minitest::Mock::new "test_location"
		def fake_location.name; "Cathedral"; end
		@my_sim.driver.location = @my_sim.cathedral
		assert_equal true, @my_sim.check_for_leaving(fake_location, 2)
	end
	
	#this will test to ensure that the check_for_leaving method will return false when the current iteration is not leaving via Monroeville or Downtown
	#mock object created for location
	#should successfully refute the check_for_leaving true
	def test_check_for_leaving_to_move_false
		fake_location = Minitest::Mock::new "test_location"
		def fake_location.name; "Hillman"; end
		@my_sim.driver.location = @my_sim.hillman
		refute_equal true, @my_sim.check_for_leaving(fake_location, 1)
	end
	
	#unit tests for check_valid_move to_move
	#0, 1, 2, 3 -> return true or false
	#all other integers -> raise "this location does not exist. error"
	#this method checks to see if a move is valid when an iteration attempts to move either north, west, south, or east
	#this test should return true when the driver attempts to move from the hospital location to the cathedral location
	def test_for_valid_move_true
		@my_sim.driver.location = @my_sim.hospital
		assert_equal true, @my_sim.check_valid_move(2)
	end
	
	
	#this test should return false when the driver attempts to move from the cathedral location to the hillman location
	def test_for_valid_move_false
		@my_sim.driver.location = @my_sim.cathedral
		refute_equal true, @my_sim.check_valid_move(0)
	end
	
	#the user will attempt to move to a location that does not exist
	#this test will use an input of a location that does not exist. An error should be raised saying "this location does not exist. Error"
	#EDGE CASE
	
	def test_for_valid_move_edge
		@my_sim.driver.location = @my_sim.cathedral
		assert_raises "The location does not exist. Error"do
		@my_sim.check_valid_move(5)
		end
	
	end
	
	#unit tests for set_driver_location_initial
	#this test will check to see that the initial location of the driver is one of the possibile locations 
	#this test has no paremeters so it will either include the location where the driver was placed or nil if no driver placed
	
	def test_initial_location_valid_location
		assert_includes [@my_sim.cathedral, @my_sim.hospital, @my_sim.hillman, @my_sim.museum], @my_sim.set_driver_location_initial
	end
	
	#unit test for move to_move
	#valid move -> return road
	#invalid move -> return nil
	#this method will move the driver to the new location and will return the road that they used to get to that location
	
	def test_move
		@my_sim.driver.location = @my_sim.cathedral
		assert_equal "Bar St", @my_sim.move(3)
	end
	
	#this test will attempt to move to a position in the city that cannot be accessed from the current position
	#this method should return nil in this case
	#EDGE CASE
	
	def test_move_bad
		@my_sim.driver.location = @my_sim.cathedral
		assert_nil @my_sim.move(1)
	end
	
	
	#unit test for get_current_loc method
	#only one test since the method has no parameters and should do the same thing everytime(return the current location)
	
	
	def test_get_current_loc
		@my_sim.driver.location = @my_sim.cathedral
		assert_equal @my_sim.cathedral, @my_sim.get_current_loc
	
	end
	
	
	#unit tests for print_final_count
	#this test will test the print_final_count statement to make sure each item is printed in singular form
	#single number of books,toys,classes -> print singlular form
	#plural or zero number of books, toy, classes -> print plural form
	def test_final_count_single
		fake_driver = Minitest::Mock::new "test_location"
		def fake_driver.num_books; 1; end
		def fake_driver.num_toys; 1 end
		def fake_driver.num_classes; 1; end
		def fake_driver.name; "test_driver"; end
		assert_output(/test_driver obtained 1 book!\ntest_driver obtained 1 dinosaur toy!\ntest_driver attended 1 class!/) {@my_sim.print_final_count(fake_driver)}
	end
	
	#this test will test the print_final_count statement to make sure each item is printed in plural form
	def test_final_count_plural
		fake_driver = Minitest::Mock::new "test_location"
		def fake_driver.num_books; 2; end
		def fake_driver.num_toys; 4 end
		def fake_driver.num_classes; 4; end
		def fake_driver.name; "test_driver"; end
		assert_output(/test_driver obtained 2 books!\ntest_driver obtained 4 dinosaur toys!\ntest_driver attended 4 classes!/) {@my_sim.print_final_count(fake_driver)}
	
	end
	
	
	
end