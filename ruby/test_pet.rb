require 'minitest/autorun'
require_relative 'pet_shelter'
require_relative 'pet'

describe "Pet" do
  it "creates a new Pet" do
    pet = Pet.new
    assert_equal pet.happiness, 50
    assert_equal pet.energy, 50
    assert_equal pet.sleeping, false
  end
end
