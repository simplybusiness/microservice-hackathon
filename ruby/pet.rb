# frozen_string_literal: true

class Pet
  attr_accessor :happiness, :energy, :sleeping
  attr_reader :name

  def initialize(name)
    @name = name
    @happiness = 50
    @energy = 50
    @sleeping = false
  end

  def to_h
    {
      "pet_name": name,
      "sleeping": sleeping,
      "energy": energy,
      "happiness": happiness
    }
  end

  def get_tired
    @happiness -= 10
    @energy -= 10
  end

  def sleep
    @sleeping = true
  end

  def wake_up
    @sleeping = false
  end

  def fed
    @energy += 10
  end

  def entertained
    @happiness += 10
  end
end
