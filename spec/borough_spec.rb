require_relative '../lib/borough.rb'
require 'json'

RSpec.describe Borough do
  it 'can change its number of infected people' do
    borough = Borough.new(population: 100, name: "Hackney", infected_population: 1, neighbours: [])
    borough.change_in_infected(5)
    expect(borough.infected_population).to eq 6
  end

  it 'can be converted into json' do
    borough = Borough.new(population: 100, name: "Hackney", infected_population: 1, neighbours: [{ name: 'Islington', percentage_infected: 3 }])
    json_body = JSON.parse(borough.to_json)

    expect(json_body["name"]).to eq("Hackney")
    expect(json_body["population"]).to eq(100)
    expect(json_body["infected_population"]).to eq(1)
    expect(json_body["neighbours"]).to eq([{ "name" => 'Islington', "percentage_infected" => 3 }])
  end
end
