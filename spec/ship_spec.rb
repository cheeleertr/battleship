require 'spec_helper'

RSpec.describe Ship do
    before :each do
        @cruiser = Ship.new("Cruiser", 3)
    end

    describe "#initialize" do
        it "exists" do
            expect(@cruiser).to be_an_instance_of(Ship)
        end

        it "has a name" do
            expect(@cruiser.name).to eq("Cruiser")
        end

        it "has a length" do
            expect(@cruiser.length).to eq(3)
        end

        it "has health" do
            expect(@cruiser.health).to eq(3)
        end
    end

    describe "#sunk?" do
        it "returns false if health is greater than 0" do
            expect(@cruiser.sunk?).to be(false)
        end

        it "returns true if health is 0" do
            expect(@cruiser.sunk?).to be(false)

            @cruiser.hit

            expect(@cruiser.health).to eq(2)

            @cruiser.hit

            expect(@cruiser.health).to eq(1)

            expect(@cruiser.sunk?).to be(false)

            @cruiser.hit

            expect(@cruiser.sunk?).to be(true)
        end
    end

    describe "hit" do
        it "decreases health by 1" do
            expect(@cruiser.health).to eq(3)

            @cruiser.hit

            expect(@cruiser.health).to eq(2)
        end
    end
end