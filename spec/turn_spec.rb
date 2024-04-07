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
            expect(@Turn).to be_an_instance_of(Turn)
        end

        it 'has a player' do
            expect(@turn.player).to eq(@player_1)
        end

        it 'has a computer player' do
            expect(@turn.computer_player).to eq(@computer_player)
        end
    end
end