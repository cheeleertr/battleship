class Board
  attr_reader :cells

  def initialize(rows = "A".."D", columns = 1..4)
    @rows = rows
    @columns = columns
    @cells = {}
      @rows.each do |row|
        @columns.each do |column|
          @cells["#{row}#{column}"] = Cell.new("#{row}#{column}")
        end
      end
  end

  def validate_single_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def validate_coordinates?(coordinates)
    found = coordinates.find do |coordinate| 
      !validate_single_coordinate?(coordinate)
    end

    found.nil?
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length || overlap?(coordinates)
      false
    else
      row = coordinates.map do |coordinate| 
        coordinate[0]
      end

      column = coordinates.map do |coordinate|
        coordinate[1]
      end

      ("1234".include?(column.join) || "ABCD".include?(row.join)) && (all_equal?(column) || all_equal?(row))
    end
  end

  def all_equal?(array)
    array.uniq.length == 1
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) && validate_coordinates?(coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    else
      false
    end
  end

  def overlap?(coordinates)
    a = coordinates.find do |coordinate|
        !@cells[coordinate].empty?
    end

    if a.nil?
      false
    else
      true
    end
  end

  def render(show_ship = false)
    # "  1 2 3 4 \n" +
    # "A #{@cells['A1'].render(show_ship)} #{@cells['A2'].render(show_ship)} #{@cells['A3'].render(show_ship)} #{@cells['A4'].render(show_ship)} \n" +
    # "B #{@cells['B1'].render(show_ship)} #{@cells['B2'].render(show_ship)} #{@cells['B3'].render(show_ship)} #{@cells['B4'].render(show_ship)} \n" +
    # "C #{@cells['C1'].render(show_ship)} #{@cells['C2'].render(show_ship)} #{@cells['C3'].render(show_ship)} #{@cells['C4'].render(show_ship)} \n" +
    # "D #{@cells['D1'].render(show_ship)} #{@cells['D2'].render(show_ship)} #{@cells['D3'].render(show_ship)} #{@cells['D4'].render(show_ship)} \n"
    
    
    line1 = [" "].join
    @columns.to_a.each do |num|
      line1 << num.to_s + " "
    end
    line1 << "\n"

    render_this = [line1].join

    @rows.to_a.each do |letter|
      matching_cells = @cells.select do |coordinate, cell|
        cell.coordinate[0] == letter
      end
# binding.pry
      rendering_cells = matching_cells.map do |cell|
        cell[1].render(show_ship)
      end.join(" ")

      next_row = ["#{letter}"].join(" ")
      next_row << rendering_cells
      next_row << "\n"
      render_this << next_row
    end
    render_this
  end
end

