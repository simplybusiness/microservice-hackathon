require 'mqtt'
require 'json'

MQTT_HOST = ENV['MQTT_HOST'] || 'mqtt.fluux.io'

# Publish example
MQTT::Client.connect(MQTT_HOST) do |c|
  c.publish('uservicehack/mutation', {infection_rate: 22}.to_json)
end


