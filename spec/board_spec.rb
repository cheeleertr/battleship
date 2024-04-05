require 'spec_helper'

RSpec.describe Board do
  before :each do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do
    it 'exists' do

    expect(@board).to be_an_instance_of(Board)
    end

    it 'has cells' do

      expect(@board.cells.values).to all(be_a(Cell))
    end

    it 'is a hash' do
      
      expect(@board.cells).to be_a(Hash)
    end

    it 'has 16 cells' do

      expect(@board.cells.length).to eq(16)
    end
  end

  describe 'validate_coordinates?' do
    it 'validates coordinates exist' do
      
      expect(@board.validate_coordinates?("A1")).to eq(true)
      expect(@board.validate_coordinates?("D4")).to eq(true)
      expect(@board.validate_coordinates?("A5")).to eq(false)
      expect(@board.validate_coordinates?("E1")).to eq(false)
      expect(@board.validate_coordinates?("A22")).to eq(false)
    end
  end

  describe 'valid_placement?' do
    it 'verifies if ships can be placed at the coordinates' do

      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
    end

    it 'makes sure the coordinates are consecutive' do

      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
    end

    it 'makes sure the placement is not diagonal' do
      
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
    end

    it 'makes sure the placement is valid with correct coordinates' do

      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
    end

    # it 'makes sure ships can not overlap' do
    #   @board.place(@cruiser, ["A1", "A2", "A3"])

    #   expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
    # end
  end

  describe "#place" do
    it 'adds a ship to the board' do
      @board.place(@cruiser, ["A1", "A2", "A3"]) 

      cell_1 = @board.cells["A1"] 

      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]    

      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)

      expect(cell_2.ship).to eq(cell_3.ship)
    end
  end

  describe 'overlap?' do
    it 'checks if specified coordinates are empty' do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      expect(@board.overlap?(["A1", "B1"])).to eq(true)
    end
  end
end