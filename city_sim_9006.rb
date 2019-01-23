


class CitySim9006

	
require_relative 'player'
require_relative 'location'
require_relative 'args_checker'
require_relative 'sim'

#execution starts here	

#checks for valid seed input
arg_checker = ArgsChecker::new
my_seed = arg_checker.check_args ARGV

#creates pseudorandom number generator with seed
prng = Random::new my_seed

puts "Starting the simulation"
#creates the 5 drivers that will run the simulation
driver1 = Player::new "Driver 1"
driver2 = Player::new "Driver 2"
driver3 = Player::new "Driver 3"
driver4 = Player::new "Driver 4"
driver5 = Player::new "Driver 5"

#sim driver1
sim1 = Sim::new driver1, prng
first_loc = sim1.set_driver_location_initial #initial driver location
sim1.increase_count first_loc
while sim1.sim_finished == false
	to_move = sim1.get_new_position #get a new location for the driver to move to
	valid = sim1.check_valid_move to_move #check to make sure the potential move is valid
	cur = sim1.get_current_loc
	sim1.check_for_leaving cur, to_move #check to see if leaving the city via downtown or monroeville
	if valid == true
		via_road = sim1.move to_move #move the driver
		sim1.print_iteration via_road, to_move #print the movement of the driver
		cur = sim1.get_current_loc
		sim1.increase_count cur
	end
end
sim1.print_final_count sim1.driver #print the final count of each item collected and classes visited


#sim driver2
sim2 = Sim::new driver2, prng
first_loc = sim2.set_driver_location_initial
sim2.increase_count first_loc
while sim2.sim_finished == false
	to_move = sim2.get_new_position
	valid = sim2.check_valid_move to_move
	cur = sim2.get_current_loc
	sim2.check_for_leaving cur, to_move
	if valid == true
		via_road = sim2.move to_move
		sim2.print_iteration via_road, to_move
		cur = sim2.get_current_loc
		sim2.increase_count cur
	end
end
sim2.print_final_count sim2.driver

#sim driver3
sim3 = Sim::new driver3, prng
first_loc = sim3.set_driver_location_initial
sim3.increase_count first_loc
while sim3.sim_finished == false
	to_move = sim3.get_new_position
	valid = sim3.check_valid_move to_move
	cur = sim3.get_current_loc
	sim3.check_for_leaving cur, to_move
	if valid == true
		via_road = sim3.move to_move
		sim3.print_iteration via_road, to_move
		cur = sim3.get_current_loc
		sim3.increase_count cur
	end
end
sim3.print_final_count sim3.driver

#sim driver4
sim4 = Sim::new driver4, prng
first_loc = sim4.set_driver_location_initial
sim4.increase_count first_loc
while sim4.sim_finished == false
	to_move = sim4.get_new_position
	valid = sim4.check_valid_move to_move
	cur = sim4.get_current_loc
	sim4.check_for_leaving cur, to_move
	if valid == true
		via_road = sim4.move to_move
		sim4.print_iteration via_road, to_move
		cur = sim4.get_current_loc
		sim4.increase_count cur
	end
end
sim4.print_final_count sim4.driver

#sim driver5
sim5 = Sim::new driver5, prng
first_loc = sim5.set_driver_location_initial
sim5.increase_count first_loc
while sim5.sim_finished == false
	to_move = sim5.get_new_position
	valid = sim5.check_valid_move to_move
	cur = sim5.get_current_loc
	sim5.check_for_leaving cur, to_move
	if valid == true
		via_road = sim5.move to_move
		sim5.print_iteration via_road, to_move
		cur = sim5.get_current_loc
		sim5.increase_count cur
	end
end
sim5.print_final_count sim5.driver

puts "The simulation is now completed."
#simulation is over
end