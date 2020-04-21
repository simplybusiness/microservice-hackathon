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
    update_hapiness(-10)
    update_energy(-10)
  end

  def sleep
    @sleeping = true
  end

  def wake_up
    @sleeping = false
  end

  def fed
    update_energy(10)
  end

  def entertained
    update_hapiness(10)
  end

  def alive?
    @happiness > 0 && @energy > 0
  end

  private

  def update_hapiness(amount)
    @happiness = [ @happiness + amount , 100].min
  end

  def update_energy(amount)
    @energy = [ @energy + amount , 100].min
  end
end
