require 'spec_helper'

RSpec.describe Game do
  before :each do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player_1 = Player.new
    @computer_player = Player.new
    @player_1.add_ship(@cruiser)
    @player_1.add_ship(@submarine)
    @computer_player.add_ship(@cruiser)
    @computer_player.add_ship(@submarine)

    @game = Game.new(@player_1, @computer_player)
  end

  describe '#initialize' do
    it 'exists' do

    expect(@game).to be_an_instance_of(Game)
    end

    it 'has players' do

      expect(@game.player_1).to eq(@player_1)
      expect(@game.computer_player).to eq(@computer_player)
    end
  end

  describe '#random_coordinate' do
    it 'has valid number of coordinates' do

      expect(@game.random_coordinate(@cruiser).length).to eq(@cruiser.length)
    end

    it 'has each random coordinate is valid' do

      expect(@player_1.board.validate_coordinates?(@game.random_coordinate(@cruiser))).to be(true)
    end

    it 'has random consecutive coordinates' do

      expect(@player_1.board.valid_placement?(@cruiser, @game.random_coordinate(@cruiser))).to be(true)
    end
  end

  # describe 'computer_player_place_ships' do
  #   it 'can place ships in valid coordinates' do

  #     expect(@game.computer_player_place_ships).to be(true)
  #   end
  # end

  # describe 'player_1_place_ships' do
  #   it 'can place ships in valid coordinates' do

  #     expect(@game.player_1_place_ships).to be(true)
  #   end
  # end
end