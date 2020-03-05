class Borough

  attr_reader :population, :name, :infected_population, :neighbours

  def initialize(population:, name:, infected_population:, neighbours:)
    @population = population
    @name = name
    @infected_population = infected_population
    @neighbours = neighbours
  end

  def change_in_infected(change)
    @infected_population += change
  end

  def to_json
    { population: population,
      name: name,
      infected_population:  infected_population,
      neighbours:  neighbours }.to_json
  end
end
