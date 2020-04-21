class PetShelter

  @@pets = {}

  def self.count
    @@pets.size
  end

  def self.adopt
    pet = Pet.new
    @@pets[pet.name] = pet
  end
end
