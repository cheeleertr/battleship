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

            @cell.fire_upon

            expect(@cell.ship.health).to eq(2)
        end
    end
end