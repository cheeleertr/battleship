class Player
  attr_reader :ships, :board

  def initialize(board = Board.new)
    @ships = []
    @board = board
  end

  def place_ship(ship, coordinates)
    @board.place(ship, coordinates)
  end

  def add_ship(ship)
    @ships << ship
  end

  def new_board
    @board = Board.new
  end
end