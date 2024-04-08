require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/player'
require './lib/ship'
require './lib/turn'
require './lib/maker'

loop do

cruiser_1 = Ship.new("Cruiser", 3)
cruiser_2 = Ship.new("Cruiser", 3)
submarine_1 = Ship.new("Submarine", 2)
submarine_2 = Ship.new("Submarine", 2)

maker = Maker.new
board = maker.create_board
binding.pry
player_1 = Player.new(board)
computer_player = Player.new(board)



player_1.add_ship(cruiser_1)
player_1.add_ship(submarine_1)
computer_player.add_ship(cruiser_2)
computer_player.add_ship(submarine_2)

game = Game.new(player_1, computer_player)

break if game.main_menu == "You chose to quit."
end