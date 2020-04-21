class PetShelter

  @@pets = {}

  def self.get(name)
    @@pets[name]
  end

  def self.count
    @@pets.size
  end

  def self.adopt(name)
    pet = Pet.new(name)
    @@pets[pet.name] = pet
  end
end
