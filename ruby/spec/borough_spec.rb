require_relative '../lib/borough.rb'

RSpec.describe Borough do
  it 'can change its number of infected people' do
    borough = Borough.new(population: 100, name: "Hackney", infected_population: 1, neighbours: [])
    borough.change_in_infected(5)
    expect(borough.infected_population).to eq 6
  end
end
