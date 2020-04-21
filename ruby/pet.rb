class Pet
  attr_accessor :happiness, :energy, :sleeping
  attr_reader :name

  def initialize(name)
    @name = name
    @happiness = 50
    @energy = 50
    @sleeping = false
  end
end
