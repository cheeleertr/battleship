require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/player'
require './lib/ship'
require './lib/turn'
require './lib/maker'

cruiser_1 = Ship.new("Cruiser", 3)
cruiser_2 = Ship.new("Cruiser", 3)
submarine_1 = Ship.new("Submarine", 2)
submarine_2 = Ship.new("Submarine", 2)

maker = Maker.new
maker.create_ships
ships = maker.custom_ships
computer_ships = maker.computer_custom_ships
board = maker.create_board


if board.nil? 
  player_1 = Player.new
  computer_player = Player.new
else
  board_2 = Board.new(board.rows, board.columns)  
  player_1 = Player.new(board)
  computer_player = Player.new(board_2)
end

if ships.empty?
  player_1.add_ship(cruiser_1)
  player_1.add_ship(submarine_1)
  computer_player.add_ship(cruiser_2)
  computer_player.add_ship(submarine_2)
else
  ships.each do |ship|
    if ship.length <= player_1.board.columns.to_a.length || ship.length <= player_1.board.rows.to_a.length
      player_1.add_ship(ship)
    end
  end

  computer_ships.each do |ship|
    if ship.length <= computer_player.board.columns.to_a.length || ship.length <= computer_player.board.rows.to_a.length
      computer_player.add_ship(ship)
    end
  end
end
# binding.pry
game = Game.new(player_1, computer_player)

game.main_menu
