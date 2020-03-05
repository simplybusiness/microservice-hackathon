require 'rubygems'
require 'mqtt'

MQTT_HOST = 'mqtt.fluux.io'

# Publish example
MQTT::Client.connect(MQTT_HOST) do |c|
  c.publish('uservicehack/borough', 'I love kittenz!')
end
