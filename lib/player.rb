class Player
  attr_reader :ships, :board

  def initialize
    @ships = []
    @board = Board.new
  end

  def place_ship(cruiser, coordinates)
    @board.place(cruiser, coordinates)
  end

  def add_ship(ship)
    @ships << ship
  end
end