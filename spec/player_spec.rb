require 'spec_helper'

RSpec.describe Board do
  before :each do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player_1 = Player.new([@cruiser, @submarine])

  end

  describe '#initialize' do
    it 'exits' do

    expect(@player_1).to be_an_instance_of(Player)
    end

    it 'has ships' do

    expect(@player_1.ships).to eq([@cruiser, @submarine])
    end

    it 'has a board' do

    expect(@player_1.board).to be_an_instance_of(Board)
    end
  end

  describe '#place_ship' do
    it 'places a ship on the board' do
      @player_1.place_ship(@cruiser, ["A1", "A2", "A3"])

      expect(@player_1.board.cells["A1"].ship).to eq(@cruiser)
    end
  end
end