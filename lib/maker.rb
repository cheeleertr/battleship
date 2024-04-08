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
    #validate entry
    while response == y
    puts "Create a new board"
    puts "Determine the height of the board by entering a letter between A - Z"
    row_end = gets.chomp.capitalize
  
    if "A".."Z".to_a.join.include?(row_end.to_a.join) 
      #validation entry
  
    rows = "A".."#{row_end}"
  
    puts "Determine the width of the board by intering a number between 1 - 25"
    column_end = gets.chomp
  
    if 1..25.to_a.join.include?(column_end)
     #validate entry
  
    columns = 1..column_end.to_i
    board = Board.new(rows, columns)
    puts "your board will look like this:"
    board.render
    puts "Do you want to recreate the board?"
    puts "Enter 'y' to recreate board or 'n' to keep this board"
    response = gets.chomp.lowercase
    validate_y_n(response)
    Board.new(rows, columns)
    end
  
  end
  
  #should default ships to be cruiser and submarine
  
  def create_ship
  puts "Would you like to create a ship?"
  puts "Enter 'y' to create a ship or 'n' to not create a ship"
  response = gets.chomp
  validate_y_n(response)
  
  while response == "y"
  puts "Choose the name of your ship"
  name = gets.chomp.
  puts "choose length of ship"
  puts "keep in mind length of ship should be less the board's max board width or height."
  length = gets.chomp.to_i
  puts "choose ship's length"
  #validate entry with board length
  
  name + "_1" = Ship.new(name, length)
  name + "_2" = Ship.new(name, length)
  @player_1.add_ship(name + "_1")
  @computer_player.add_ship(name + "_2")
  puts "Your ship has been created"
  puts "Your ships are: #{player.ships}"
  puts "Did you want to add another ship?"
  puts "Enter 'y' to create another ship or 'n' to not create a ship"
  response = gets.chomp.lowercase
  validate_y_n(response)
  break if gets.chomp != "yes"
  end
  end
  
  
  #use in module
  def validate_y_n(response)
    loop do 
      break if response == y || response == n
      puts "Invalid. Please enter 'y' or 'n'"
      response = gets.chomp
      end
    end
  end
end