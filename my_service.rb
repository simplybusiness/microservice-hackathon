require 'rubygems'
require 'mqtt'
require_relative 'lib/borough'
require 'json'

SERVICE_NAME = 'borough'
MQTT_HOST = 'mqtt.fluux.io'

# Subscribe example
MQTT::Client.connect(MQTT_HOST) do |c|
  # If you pass a block to the get method, then it will loop
  # The '#' wildcard subscribes to all topics below this one
  c.get('uservicehack/time') do |topic,message|
    boroughs.each do |borough|
      c.publish('uservicehack/borough', borough.to_json)
    end
  end
end
