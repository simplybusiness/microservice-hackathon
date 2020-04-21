require 'minitest/autorun'
require_relative 'pet_shelter'
require_relative 'pet'

describe "Pet Shelter" do
  it "returns a new pet when adoption is requested" do
    assert_equal PetShelter.count, 0
    PetShelter.adopt("Toto")
    assert_equal PetShelter.count, 1
  end

  it "gets the adopted pet" do
    PetShelter.adopt("Toto")
    assert PetShelter.get("Toto")
  end
end
