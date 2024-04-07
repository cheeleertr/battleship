require 'spec_helper'

RSpec.describe Turn do
    before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

    @player_1 = Player.new
    @computer_player = Player.new

    @player_1.add_ship(@cruiser)
    @player_1.add_ship(@submarine)

    @computer_player.add_ship(@cruiser)
    @computer_player.add_ship(@submarine)

    @turn = Turn.new(@player_1, @computer_player)
    end

    describe "#initialize" do
        it 'exists' do
            expect(@turn).to be_an_instance_of(Turn)
        end

        it 'has a player' do
            expect(@turn.player_1).to eq(@player_1)
        end

        it 'has a computer player' do
            expect(@turn.computer_player).to eq(@computer_player)
            binding.pry
        end
    end

    describe '#display_computer_board' do
        it 'can display the computer board' do
            @computer_player.board.place(@cruiser, ["A1", "A2", "A3"])

            expected = "=============COMPUTER BOARD=============\n" \
                        "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

            expect(@turn.display_computer_board).to eq(expected)
        end
    end

    describe '#display_player_board' do
        it 'can display the player board with placed ships' do
            @player_1.board.place(@cruiser, ["B1", "B2", "B3"])

            expected = "==============PLAYER BOARD==============\n" \
                        "  1 2 3 4 \nA . . . . \nB S S S . \nC . . . . \nD . . . . \n"

            expect(@turn.display_player_board).to eq(expected)
        end
    end

    # describe '#display_boards' do
    #     it 'can display the computer and player boards' do
    #         @computer_player.board.place(@cruiser, ["A1", "A2", "A3"])
    #         @player_1.board.place(@cruiser, ["B1", "B2", "B3"])

    #         expected = "=============COMPUTER BOARD=============\n" \
    #                     "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n" \
    #                     "==============PLAYER BOARD==============\n" \
    #                     "  1 2 3 4 \nA . . . . \nB S S S . \nC . . . . \nD . . . . \n"

    #         expect(@turn.display_boards).to eq(expected) #returning nil - how to test?
    #     end
    # end
end