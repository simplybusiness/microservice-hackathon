require 'rubygems'
require 'mqtt'
require_relative 'lib/borough'
require 'json'

SERVICE_NAME = 'borough'
MQTT_HOST = 'mqtt.fluux.io'

boroughs = [
    Borough.new(name: "Camden", population: 10000, infected_population: 1, neighbours: [{ "name" => 'Westminster', "percentage_infected" => 3 },{ "name" => 'Islington', "percentage_infected" => 3 }, { "name" => 'City of London', "percentage_infected" => 3 }]),
    Borough.new(name: "Westminster", population: 478435, infected_population: 0, neighbours: [{ "name" => 'Camden', "percentage_infected" => 3 },{ "name" => 'City of London', "percentage_infected" => 3 }]),
    Borough.new(name: "Hackney", population: 47784, infected_population: 0, neighbours: [{ "name" => 'Islington', },{ "name" => 'Islington', "percentage_infected" => 3 }]),
    Borough.new(name: "Southwark", population: 23269, infected_population: 0, neighbours: []),
    Borough.new(name: "Islington", population: 323124, infected_population: 0, neighbours: []),
    Borough.new(name: "City of London", population: 50, infected_population: 45, neighbours: [])
]
# Subscribe example
MQTT::Client.connect(MQTT_HOST) do |c|
  # If you pass a block to the get method, then it will loop
  # The '#' wildcard subscribes to all topics below this one
  c.get('uservicehack/time') do |topic,message|
    boroughs.each do |borough|
      c.publish('uservicehack/borough', borough.to_json)
      sleep 1
    end
  end
end
