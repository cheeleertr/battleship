
require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/player'
require './lib/ship'
require './lib/turn'
require './lib/maker'

class Game
  attr_reader :player_1,
              :computer_player,
              :board,
              :board_2

  def initialize
    @player_1 = Player.new
    @computer_player = Player.new
    @maker = Maker.new
    @board = Board.new
    @board_2 = Board.new

  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play, q to quit."
    response = gets.chomp.downcase
    loop do
      break if response == "p" || response == "q"
      puts "Invalid. Please enter 'p' or 'q'"
      response = gets.chomp.downcase
    end

    if response == "q"
      return "You chose to quit."
    end

    setup
  end

  def setup
    create_custom_board
    create_custom_ships
    add_board
    add_ships
    computer_player_place_ships
    computer_player_place_ships_text
    explain_ship_placement
    player_1_place_ships
    game_loop
  end

  def game_loop
    while @player_1.board.render(true).include?("S") && @computer_player.board.render(true).include?("S")
      turn = Turn.new(@player_1, @computer_player)
      turn.player_shot_results(turn.player_shot)
      turn.computer_shot_results(turn.computer_shot)
    end
    results(turn)
    end_game
    reset
    main_menu
  end

  def end_game
    puts "\n"
    if !@computer_player.board.render(true).include?("S")
      puts "You won!"
    elsif !@player_1.board.render(true).include?("S")
      puts "I won!"
    end
    puts "\n"
  end

  def reset
    @player_1 = Player.new
    @computer_player = Player.new
    @maker = Maker.new
    @board = Board.new
    @board_2 = Board.new
  end

  def results(turn)
    turn.display_boards
  end

  def computer_player_place_ships
    @computer_player.ships.each do |ship|
      coord = random_coordinate(ship)
      @computer_player.board.place(ship, coord)
    end
  end

  def random_coordinate(ship)
    sample_coords = @computer_player.board.cells.keys.sample(ship.length)
    while !@computer_player.board.valid_placement?(ship, sample_coords) || !@computer_player.board.validate_coordinates?(sample_coords)
        sample_coords = @computer_player.board.cells.keys.sample(ship.length)
    end
    sample_coords
  end

  def computer_player_place_ships_text
    puts "\n"
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your ships."
  end

  def explain_ship_placement
    @player_1.ships.each do |ship|
      puts "\n"
      puts "Place your #{ship.name}. The #{ship.name} requires #{ship.length} coordinates."
      puts "Those coordinates must be separated by a space."
      puts "ex: A1 B1 C1, or D3 D4"
      puts "\n"
    end
  end

  def player_1_place_ships
    @player_1.ships.each do |ship|
      puts "Your board:"
      puts "\n"
      puts @player_1.board.render(true)
      puts "\n"
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces): "
      puts "\n"
      response = gets.chomp.upcase.split(" ").sort
      while !@player_1.board.valid_placement?(ship, response)
        puts "Those are invalid coordinates. Please try again:"
        response = gets.chomp.upcase.split(" ").sort
      end
      @player_1.board.place(ship, response)
    end
  end

  def create_custom_ships
    @maker.create_ships
    ships = @maker.custom_ships
    computer_ships = @maker.computer_custom_ships
  end

  def create_custom_board
    custom_board = @maker.create_board
    if !custom_board.nil?
      @board = custom_board
    end
    @board_2 = Board.new(@board.rows, @board.columns)
  end

  def add_board
    @player_1 = Player.new(@board)
    @computer_player = Player.new(@board_2)
  end

  def add_ships
    if @maker.custom_ships.empty?
      cruiser_1 = Ship.new("Cruiser", 3)
      cruiser_2 = Ship.new("Cruiser", 3)
      submarine_1 = Ship.new("Submarine", 2)
      submarine_2 = Ship.new("Submarine", 2)
      @player_1.add_ship(cruiser_1)
      @player_1.add_ship(submarine_1)
      @computer_player.add_ship(cruiser_2)
      @computer_player.add_ship(submarine_2)
    else
      @maker.custom_ships.each do |ship|
        if ship.length <= @player_1.board.columns.to_a.length || ship.length <= @player_1.board.rows.to_a.length
          @player_1.add_ship(ship)
        end
      end
      @maker.computer_custom_ships.each do |ship|
        if ship.length <= @computer_player.board.columns.to_a.length || ship.length <= @computer_player.board.rows.to_a.length
          @computer_player.add_ship(ship)
        end
      end
    end
  end
end
