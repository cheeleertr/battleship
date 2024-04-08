class Cell
    attr_reader :coordinate
    attr_accessor :ship, :fired_upon

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        @ship.nil?
    end

    def place_ship(ship)
        @ship = ship
    end

    def fire_upon
        @fired_upon = true
        if empty?
            false
        else
            @ship.hit
        end
    end

    def fired_upon?
        @fired_upon
    end

    def render(show = false)
        show_ship = show
        if fired_upon? && empty?
            "M"
        elsif fired_upon? && @ship.sunk?
            "X"
        elsif fired_upon? && !empty?
            "H"
        elsif !empty? && show_ship
            "S"
        else
            "."
        end
    end
end