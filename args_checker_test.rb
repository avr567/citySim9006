require 'minitest/autorun'
require_relative 'args_checker'


class ArgsCheckerTest < Minitest::Test




def setup
	@arg_checker = ArgsChecker::new
end

  
  
  #Unit tests for method check_args arr
  #Equivalence classes:
  #arr= contains single integer -> returns the inputted integer
  #arr= single value that is not an integer  -> returns 0
  #arr= contains more than one value -> raises "Please enter one seed input"


  #if arr contains a single integer then that integer is returned
  def test_single_integer	
	assert_equal 15, @arg_checker.check_args([15])
  end

  #if arr contains a single value that is not an integer then 0 is returned
  #EDGE CASE
  def test_bad_single_input
	assert_equal 0, @arg_checker.check_args(['hello'])
  end
	
  #if arr contains more than one value then "Please enter one seed input" is raised
  def test_more_than_one_seed
	assert_raises "Please enter one seed input" do
	@arg_checker.check_args([10, 12])
	end
  end
  
end