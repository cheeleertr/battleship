require 'board'
require 'player'
require 'ship'
require 'cell'

class Maker
  def initialize(player_1, computer_player)
    @player_1 = player_1
    @computer_player = computer_player
  end

  def create_board
    puts "Would you like to create a custom board?"
    puts "Enter 'y' to create custom board or 'n' to not create a board"
    response = gets.chomp.lowercase
    validate_y_n(response)
    while response == y
      puts "Create a new board"
      puts "Determine the height of the board by entering a letter between A - Z"
      row_end = gets.chomp.capitalize
    
      while !"A".."Z".to_a.include?(row_end) 
        puts "Invalid. Put a letter between A-Z"
        row_end = gets.chomp.capitalize
      end
    
      rows = "A".."#{row_end}"
    
      puts "Determine the width of the board by intering a number between 1 - 25"
      column_end = gets.chomp
    
      while !1..25.to_a.include?(column_end)
        puts "Invalid. Put a number between 1- 25"
        column_end = gets.chomp
      end
    
      columns = 1..column_end.to_i
      board = Board.new(rows, columns)
      puts "Your board will look like this:"
      board.render
      puts "Do you want to recreate the board?"
      puts "Enter 'y' to recreate board or 'n' to keep this board"
      response = gets.chomp.lowercase
      validate_y_n(response)
      board
    end
  end
  
  #should default ships to be cruiser and submarine
  
  # def create_ship
  #   puts "Would you like to create a ship?"
  #   puts "Enter 'y' to create a ship or 'n' to not create a ship"
  #   response = gets.chomp
  #   validate_y_n(response)
    
  #   while response == "y"
  #     puts "Choose the name of your ship"
  #     name = gets.chomp
  #     puts "choose length of ship"
  #     puts "keep in mind length of ship should be less the board's max board width or height."
  #     length = gets.chomp.to_i
  #     puts "choose ship's length"
  #     #validate entry with board length
  #     player_ship = "#{name}" + "_1"

  #     player_ship = Ship.new(name, length)
  #     ("#{name}" + "_2") = Ship.new(name, length)
  #     @player_1.add_ship(name + "_1")
  #     @computer_player.add_ship(name + "_2")
  #     puts "Your ship has been created"
  #     puts "Your ships are: #{player.ships}"
  #     puts "Did you want to add another ship?"
  #     puts "Enter 'y' to create another ship or 'n' to not create a ship"
  #     response = gets.chomp.lowercase
  #     validate_y_n(response)
  #     break if gets.chomp != "yes"
  #   end
  # end
  
  
  #use in module
  def validate_y_n(response)
    loop do 
      break if response == y || response == n
      puts "Invalid. Please enter 'y' or 'n'"
      response = gets.chomp
    end
  end
end