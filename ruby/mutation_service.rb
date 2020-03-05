require 'mqtt'
require 'json'
require 'date'
require_relative 'infection_rate_algorithm'

MQTT_HOST = ENV['MQTT_HOST'] || 'mqtt.fluux.io'

current_infection_rate = 1

# Subscribe example
MQTT::Client.connect(MQTT_HOST) do |c|
  # If you pass a block to the get method, then it will loop
  # The '#' wildcard subscribes to all topics below this one
  c.get("uservicehack/time") do |topic,message|
    date = Time.at(JSON.parse(message)["time"])
    puts "On topic #{topic} got: #{message} - Date: #{date}"
    current_infection_rate = infection_rate_algorithm(current_infection_rate, date)
    c.publish('uservicehack/mutation', {infection_rate: current_infection_rate}.to_json)
  end
end

