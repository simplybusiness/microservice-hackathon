require 'mqtt'
require 'json'

MQTT_HOST = ENV['MQTT_HOST'] || 'mqtt.fluux.io'



# Subscribe example
MQTT::Client.connect(MQTT_HOST) do |c|
  # If you pass a block to the get method, then it will loop
  # The '#' wildcard subscribes to all topics below this one
  c.get("uservicehack/time") do |topic,message|
    puts "On topic #{topic} got: #{message}"
    c.publish('uservicehack/mutation', {infection_rate: 22}.to_json)
  end
end

