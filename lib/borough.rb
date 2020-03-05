class Borough

  attr_reader :population, :name, :infected_population, :neighbours

  def initialize(population:, name:, infected_population:, neighbours:)
    @population = population
    @name = name
    @infected_population = infected_population
    @neighbours = neighbours
  end

  def change_number_of_infected(change)
    raise "Change in infections exceeds healthy population" if change > healthy_population

    @infected_population += change
  end

  def to_json
    { population: population,
      name: name,
      infected_population:  infected_population,
      neighbours:  neighbours }.to_json
  end

  def healthy_population
    population - infected_population
  end
end
