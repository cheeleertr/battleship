class Turn
    attr_reader :player_1, :computer_player

    def initialize(player, computer_player)
        @player_1 = player
        @computer_player = computer_player
    end

    def display_computer_board
        "=============COMPUTER BOARD=============\n#{@computer_player.board.render}"
    end
end