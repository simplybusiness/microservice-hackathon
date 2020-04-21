# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'pet_shelter'
require_relative 'pet'

describe 'Pet' do
  it 'creates a new Pet' do
    pet = Pet.new('Toto')
    assert_equal pet.name, 'Toto'
    assert_equal pet.happiness, 50
    assert_equal pet.energy, 50
    assert_equal pet.sleeping, false
  end

  it 'can be casted to a hash' do
    pet = Pet.new('Toto')
    assert_equal(
      pet.to_h,
      {
        "pet_name": 'Toto',
        "sleeping": false,
        "energy": 50,
        "happiness": 50
      }
    )
  end

  it 'updates its attributes with the passage of time' do
    pet = Pet.new('Toto')
    assert_equal pet.energy, 50
    assert_equal pet.happiness, 50
    pet.get_tired
    assert_equal pet.energy, 40
    assert_equal pet.happiness, 40
  end

  it 'wakes up or sleeps with the passage of time' do
    pet = Pet.new('Toto')
    assert !pet.sleeping
    pet.sleep
    assert pet.sleeping
    pet.wake_up
    assert !pet.sleeping
  end

  it 'increases energy when fed' do
    pet = Pet.new('Toto')
    assert_equal pet.energy, 50
    pet.fed
    assert_equal pet.energy, 60
  end

  it 'does not get more than 100 energy' do
    pet = Pet.new('Toto')
    pet.energy = 100
    pet.fed
    assert_equal pet.energy, 100
  end

  it 'does not get more than 100 happiness' do
    pet = Pet.new('Toto')
    pet.happiness = 100
    pet.entertained
    assert_equal pet.happiness, 100
  end

  it 'increases happiness when entertained' do
    pet = Pet.new('Toto')
    assert_equal pet.happiness, 50
    pet.entertained
    assert_equal pet.happiness, 60
  end

  it 'dies when happiness is 0' do
    pet = Pet.new('Toto')
    assert pet.alive?
    pet.happiness = 0
    assert !pet.alive?
  end

  it 'dies when energy is 0' do
    pet = Pet.new('Toto')
    assert pet.alive?
    pet.energy = 0
    assert !pet.alive?
  end
end
