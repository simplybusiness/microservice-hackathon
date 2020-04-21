# Imports
require 'aws_iot_device'
require 'pry'
require_relative 'pet_shelter'
require_relative 'pet'

# Configuration
host = "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com"
port = 8883
certificate_path = "../certs/certificate.pem.crt"
private_key_path = "../certs/private.pem.key"
root_ca_path = "../certs/root-CA.pem"
topic = "workshop/pet"
service_name = 'pet'

# MQTT client
client = AwsIotDevice::MqttShadowClient::MqttManager.new(host: host, port: port, ssl: true)
client.config_ssl_context(root_ca_path, private_key_path, certificate_path)
client.connect

def wrap_payload(payload)
  payload.to_h.merge(service_name: "pet").to_json
end

client.subscribe("workshop/player/pet_adoption_requested", 0, Proc.new { |message|
  pet_name = JSON.parse(message.payload)['pet_name']
  pet = PetShelter.adopt(pet_name)
  client.publish("workshop/pet/pet_adopted", wrap_payload(pet))
})

# Loop forever publishing a new message to topic every three seconds
loop do
  # client.publish(topic, "Hello from pet service where time is now #{Time.now.to_i}")
  client.publish("workshop/player/pet_adoption_requested", { pet_name: "Bob" }.to_json)
  sleep 10
end

# Use 'client.disconnect' if you don't want to loop forever

