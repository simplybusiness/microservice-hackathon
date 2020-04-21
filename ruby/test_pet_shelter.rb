require 'minitest/autorun'
require_relative 'pet_shelter'
require_relative 'pet'

describe "Pet Shelter" do
  it "returns a new pet when adoption is requested" do
    assert_equal PetShelter.count, 0
    PetShelter.adopt
    assert_equal PetShelter.count, 1
  end
end
