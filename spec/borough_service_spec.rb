require_relative "../lib/borough_service.rb"
require_relative "../lib/borough.rb"

RSpec.describe BoroughService do

  it 'applies change in infected population to the relevant borough' do
    borough = Borough.new(population: 100, name: "Hackney", infected_population: 1, neighbours: [])
    borough_service = BoroughService.new([borough])

    borough_service.apply_change_in_infections('Hackney', 6)
    expect(borough.infected_population).to eq 7
  end

  it 'retrieves the borough given the name' do
    boroughs = [double(name: "Hackney"), double(name: "Islington")]
    borough_service = BoroughService.new(boroughs)
    expect(borough_service.find("Islington")).to eq(boroughs.last)
  end
end
