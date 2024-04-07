require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/player'
require './lib/ship'

cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)

player_1 = Player.new
computer_player = Player.new

player_1.add_ship(cruiser)
player_1.add_ship(submarine)
computer_player.add_ship(cruiser)
computer_player.add_ship(submarine)

game = Game.new(player_1, computer_player)

game.start