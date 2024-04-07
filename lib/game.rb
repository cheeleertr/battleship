class Game
  attr_reader :player_1, :computer_player

  def initialize(player_1, computer_player)

    @player_1 = player_1
    @computer_player = computer_player
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play, q to quit."
    response = gets.chomp.downcase

    if response == "q"
      return "You chose to quit."
    end

    setup
  end

  def setup
    computer_player_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    # puts "explain ship placement to player 1"
    puts "ex: cruiser, ['A1', 'B1', 'C1']"
    player_1_place_ships
    puts @player_1.board.render(true)
  end

  def computer_player_place_ships
    @computer_player.ships.each do |ship|
      coord = random_coordinate(ship)
      @computer_player.board.place(ship, coord)

      # occupied = @computer_player.board.cells.find_all do |cell|
      #   cell.ships == ship
    end
    # coord == occupied
  end

  def random_coordinate(ship)
    sample_coords = @computer_player.board.cells.keys.sample(ship.length)
    while !@computer_player.board.valid_placement?(ship, sample_coords) || !@computer_player.board.validate_coordinates?(sample_coords)
        sample_coords = @computer_player.board.cells.keys.sample(ship.length)
    end
    sample_coords
  end

  def player_1_place_ships
    @player_1.ships.each do |ship|
      puts "\n"
      puts @player_1.board.render(true)
      puts "\n"
      puts "Enter the squares for the #{ship} (#{ship.length} spaces): "
      puts "\n"
      puts "\n"
      response = gets.chomp.split(" ")
      while !@player_1.board.valid_placement?(ship, response)
        puts "Those are invalid coordinates. Please try again:"
        response = gets.chomp.split(" ")
      end
      @player_1.board.place(ship, response)
    end
  end
end
