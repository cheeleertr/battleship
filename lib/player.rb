class Player
  attr_reader :ships, :board

  def initialize(ships)
    @ships = ships
    @board = Board.new
  end

  def place_ship(cruiser, coordinates)
    @board.place(cruiser, coordinates)
  end
end