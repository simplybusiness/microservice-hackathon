require 'minitest/autorun'
require_relative 'pet_shelter'
require_relative 'pet'

describe "Pet" do
  it "creates a new Pet" do
    pet = Pet.new("Toto")
    assert_equal pet.name, "Toto"
    assert_equal pet.happiness, 50
    assert_equal pet.energy, 50
    assert_equal pet.sleeping, false
  end

  it 'can be casted to a hash' do
    pet = Pet.new("Toto")
    assert_equal(
      pet.to_h,
      {
        "pet_name": "Toto",
        "sleeping": false,
        "energy": 50,
        "happiness": 50
      }
    )
  end
end
