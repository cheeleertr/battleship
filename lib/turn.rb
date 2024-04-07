class Turn
    attr_reader :player_1, :computer_player

    def initialize(player, computer_player)
        @player_1 = player
        @computer_player = computer_player
    end

    def display_computer_board
        "=============COMPUTER BOARD=============\n#{@computer_player.board.render}"
    end

    def display_player_board
        "==============PLAYER BOARD==============\n#{@player_1.board.render(true)}"
    end

    def display_boards
        puts display_computer_board
        puts display_player_board
    end

    def player_shot
        puts "Enter the coordinate for your shot:"
        response = gets.chomp.to_s
        if @computer_player.board.validate_single_coordinate?(response)
            if  @computer_player.board.cells[response].fired_upon?
                puts "That cell has already been shot! Choose another one!"
                false
            elsif 
                @computer_player.board.cells[response].fire_upon
            else
                true
            end
        else 
            puts "Enter a coordinate between A1 - D4."
            false
        end
        response
    end

    def player_shot_results(fired_coordinate)
        hit_or_miss = if !@computer_player.board.cells[fired_coordinate].ship.nil?
            hit_or_miss = "hit"
        else
            hit_or_miss = "miss"
        end
        puts "You fired at #{fired_coordinate}. It's a #{hit_or_miss}!"
        unless hit_or_miss == "hit" && @computer_player.board.cells[fired_coordinate].ship.sunk?
            return
        end
        puts "You sunk my #{@computer_player.board.cells[fired_coordinate].ship.name}!"
    end

    def random_unfired_coordinate
        unfired_coordinates = @player_1.board.cells.map do |coord, cell|
            coord if !cell.fired_upon?
        end
        unfired_coordinates.sample
    end

    def computer_shot
        computer_coord = random_unfired_coordinate
        @player_1.board.cells[computer_coord].fire_upon
        computer_coord
    end

    def computer_shot_results(fired_coordinate)
        hit_or_miss = if !@player_1.board.cells[fired_coordinate].ship.nil?
            hit_or_miss = "hit"
        else
            hit_or_miss = "miss"
        end
        puts "I fired at #{fired_coordinate}. It's a #{hit_or_miss}!"
        # require 'pry' ; binding.pry
        if hit_or_miss == "hit" && @player_1.board.cells[fired_coordinate].ship.sunk?
            puts "I sunk your #{@player_1.board.cells[fired_coordinate].ship.name}!"
        end
    end
end