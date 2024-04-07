class Game
  attr_reader :player_1, :computer_player

  def initialize(player_1, computer_player)

    @player_1 = player_1
    @computer_player = computer_player
    
  end

  def main_menu
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
      results(turn)
    end

    end_game

    reset(@player_1)
    reset(@computer_player)

    main_menu
  end

  def end_game
    if !@computer_player.board.render(true).include?("S")
      puts "You won!"
    elsif !@player_1.board.render(true).include?("S")
      puts "I won!"
    end
  end

  def reset(player)
    player.ships.each do |ship|
      ship.health = ship.length
    end
    player.board.cells.each do |coord, cell|
      cell.ship = nil
      cell.fired_upon = false
    end
  end

  def results(turn)
    turn.display_boards
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

  def computer_player_place_ships_text
    puts "\n"
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
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
end
