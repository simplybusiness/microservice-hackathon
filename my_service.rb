require 'rubygems'
require 'mqtt'
require_relative 'lib/borough'
require 'json'

SERVICE_NAME = 'borough'
MQTT_HOST = 'mqtt.fluux.io'

boroughs = [
    Borough.new(name: "Camden", population: 10000, infected_population: 1, neighbours: ['Westminster', 'Islington', 'City of London']),
    Borough.new(name: "Westminster", population: 478435, infected_population: 0, neighbours: ['Camden', 'City of London']),
    Borough.new(name: "Hackney", population: 47784, infected_population: 0, neighbours: ['Islington', 'City of London']),
    Borough.new(name: "Southwark", population: 23269, infected_population: 0, neighbours: ['City of London']),
    Borough.new(name: "Islington", population: 323124, infected_population: 0, neighbours: ['City of London', 'Camden', 'Hackney']),
    Borough.new(name: "City of London", population: 50, infected_population: 45, neighbours: ['Islington', 'Southwark', 'Hackney', 'Camden', 'Westminster'])
]
# Subscribe example
MQTT::Client.connect(MQTT_HOST) do |c|
  # If you pass a block to the get method, then it will loop
  # The '#' wildcard subscribes to all topics below this one

  threads = []
  threads << Thread.new {
    c.get('uservicehack/time') do |topic,message|
      boroughs.each do |borough|
        c.publish('uservicehack/borough', borough.to_json)
        sleep 1
      end
    end
  }
  threads << Thread.new {
    c.get('uservicehack/infection') do |topic,message|
      puts message
    end
  }
  threads.each(&:join)
end
