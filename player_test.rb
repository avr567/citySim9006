require 'minitest/autorun'
require_relative 'player'


class PlayerTest < Minitest::Test


#only test for this class is to see  that we are creating an instance of a Player object
def test_test_player_is_player
		test_player = Player::new "test_player"
		assert test_player.is_a?(Player)
	end



end
