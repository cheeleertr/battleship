require 'spec_helper'

RSpec.describe Cell do
    before(:each) do
        @cell = Cell.new("B4")
        @cruiser = Ship.new("Cruiser", 3)
    end

    describe "#initialize" do
        it "exists" do
            expect(@cell).to be_an_instance_of(Cell)
        end

        it "has a coordinate" do
            expect(@cell.coordinate).to eq("B4")
        end

        it "has a ship with default value nil" do
            expect(@cell.ship).to eq(nil)
        end
    end

    describe "empty?" do
        it "returns true if the cell is empty" do
            expect(@cell.empty?).to be(true)

            @cell.place_ship(@cruiser)

            expect(@cell.empty?).to be(false)
        end
    end

    describe "#place_ship" do
        it "stores the ship" do
            @cell.place_ship(@cruiser)

            expect(@cell.ship).to eq(@cruiser)
        end
    end

    describe "fired_upon?" do
        it "returns false if the cell hasn't been fired upon" do
            @cell.place_ship(@cruiser)

            expect(@cell.fired_upon?).to be(false)
        end

        it "returns true if the cell has been fired upon" do
            @cell.place_ship(@cruiser)

            @cell.fire_upon

            expect(@cell.fired_upon?).to be(true)
        end
    end

    describe "fire_upon" do
        it "decrements the health of the ship" do
            @cell.place_ship(@cruiser)

            expect(@cell.ship.health).to eq(3)

            @cell.fire_upon

            expect(@cell.ship.health).to eq(2)
        end
    end

    describe "#render" do
        it "returns a period if cell has not been fired upon" do
            expect(@cell.render).to eq(".")

            @cell.place_ship(@cruiser)

            expect(@cell.render).to eq(".")
        end

        it "returns an M if cell has been fired upon and has no ship" do
            @cell.fire_upon

            expect(@cell.render).to eq("M")
        end

        it "returns an H if the cell has been fired upon and has a ship" do
            @cell.place_ship(@cruiser)

            @cell.fire_upon

            expect(@cell.render).to eq("H")
        end

        it "returns an X if the cell has been fired upon and has a ship and the ship is sunk" do
            @cell.place_ship(@cruiser)

            @cell.fire_upon
            @cell.fire_upon
            @cell.fire_upon

            expect(@cell.ship.sunk?).to be(true)

            expect(@cell.render).to eq("X")
        end

        it "returns an S if true is passed in" do
            @cell.place_ship(@cruiser)

            expect(@cell.render(true)).to eq("S")
        end

        it "still returns an H and X with true passed in" do
            cell_2 = Cell.new("C3")

            cell_2.place_ship(@cruiser)
            cell_2.fire_upon

            expect(cell_2.render(true)).to eq("H")

            expect(@cruiser.sunk?).to be(false)

            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.sunk?).to be(true)

            expect(cell_2.render(true)).to eq("X")
        end
    end
end