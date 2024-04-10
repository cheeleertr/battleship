require './lib/board'
require './lib/ship'
require "pry"

class Maker
  attr_reader :custom_ships, :computer_custom_ships

  def initialize
    @custom_ships = []
    @computer_custom_ships = []
  end

  def create_board
    puts "Would you like to create a custom board?"
    puts "Enter 'y' to create custom board or 'n' to not create a board"
    response = validate_y_n(gets.chomp.downcase)
    while response == "y"
      puts "Create a new board"
      puts "Determine the height of the board by entering a letter between C - Z"
      row_end = gets.chomp.capitalize
      while !("C".."Z").to_a.include?(row_end) 
        puts "Invalid. Put a letter between C-Z"
        row_end = gets.chomp.capitalize
      end
    
      rows = "A".."#{row_end}"
    
      puts "Determine the width of the board by intering a number between 3 - 25"
      column_end = gets.chomp.to_i
    
      while !(3..25).to_a.include?(column_end)
        puts "Invalid. Put a number between 1- 25"
        column_end = gets.chomp.to_i
      end
    
      columns = 1..column_end
      board = Board.new(rows, columns)
      puts "Your board will look like this:"
      puts board.render
      puts "Do you want to recreate the board?"
      puts "Enter 'y' to recreate board or 'n' to keep this board"
      response = validate_y_n(gets.chomp.downcase)
    end
    board
  end
  
  def create_ships
    puts "Would you like to create a ship?"
    puts "Enter 'y' to create a ship or 'n' to not create a ship"

    response = validate_y_n(gets.chomp.downcase)
    
    while response == "y"
      puts "Enter the name of your ship"
      name = gets.chomp
      puts "Enter length of ship"
      puts "Keep in mind the ship cannot be used if the ship length is greater than the board's max board width or height."
      response = gets.chomp
      loop do
        break if response.to_i != 0
        puts "Invalid. Please enter a number"
        response = gets.chomp
      end

      length = response.to_i
      
      @custom_ships << Ship.new(name, length)
      @computer_custom_ships << Ship.new(name, length)

      puts "Your ship has been created"
      ship_names = @custom_ships.map { |ship| ship.name }
      puts "Your ships are: #{ship_names}"
      puts "Did you want to add another ship?"
      puts "Enter 'y' to create another ship or 'n' to not create a ship"
      response = validate_y_n(gets.chomp.downcase)
      break if response == "n"
    end
    @custom_ships
  end
  #use in module
  def validate_y_n(response)
    loop do
      return response if response == "y" || response == "n"
      puts "Invalid. Please enter 'y' or 'n'"
      response = gets.chomp.downcase
    end
  end
end