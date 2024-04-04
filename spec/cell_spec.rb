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
end