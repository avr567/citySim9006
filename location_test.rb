require 'minitest/autorun'
require_relative 'location'


class LocationTest < Minitest::Test


#only test for this class is to see  that we are creating an instance of a Location object Setter methods do not need to be tested according to assignment
#description
def test_test_location_is_location
		test_location = Location::new "test_location", false, false, false
		assert test_location.is_a?(Location)
	end


end