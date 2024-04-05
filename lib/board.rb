class Board
  attr_reader :cells

  def initialize
    @cells = {}
      ("A".."D").each do |row|
        (1..4).each do |column|
          @cells["#{row}#{column}"] = Cell.new("#{row}#{column}")
        end
      end
  end

  def validate_coordinates?(coordinates)
    @cells.keys.include?(coordinates)
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      false
    elsif
      row = coordinates.map do |coordinate| 
        coordinate[0]
      end

      column = coordinates.map do |coordinate|
        coordinate[1]
      end

      ("1234".include?(column.join) || "ABCD".include?(row.join)) && (all_equal?(column) || all_equal?(row))
    else
      false
    end
  end
  def all_equal?(array)
    array.uniq.length == 1
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) # && validate_coordinates?
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    else
      false
    end
  end

  def overlap?(coordinates)
    coordinates.each do |coordinate|
      if @cells[coordinate].empty?
        return false
      else 
        return true
      end
    end
  end
end