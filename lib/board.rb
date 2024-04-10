class Board
  attr_reader :cells, :rows, :columns

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
        coordinate[1..-1]
      end

      ("#{@columns.to_a.join}".include?(column.join) || "#{@rows.to_a.join}".include?(row.join)) && (all_equal?(column) || all_equal?(row))
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

    line1 = [" "].join(" ")
    @columns.to_a.each do |num|
      a = " " + num.to_s
      while a.length < 3 && @columns.to_a.length >= 10
        a.prepend(" ")
      end
      line1 << a
    end
    line1 << " \n"

    render_this = [line1].join

    @rows.to_a.each do |letter|
      matching_cells = @cells.select do |coordinate, cell|
        cell.coordinate[0] == letter
      end
# binding.pry
      rendering_cells = matching_cells.map do |cell|
        cell[1].render(show_ship)
      end

      if @columns.to_a.length < 10
      rendering_cells_spaced = rendering_cells.join(" ")
      else 
      rendering_cells_spaced = rendering_cells.join("  ")
      end

      if @columns.to_a.length < 10
        next_row = ["#{letter} "].join(" ")
      else
        next_row = ["#{letter}  "].join(" ")
      end
      next_row << rendering_cells_spaced
      next_row << " \n"
      render_this << next_row
    end
    render_this
    # binding.pry
  end
end

