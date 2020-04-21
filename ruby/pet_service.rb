# frozen_string_literal: true

# Imports
require 'aws_iot_device'
require 'pry'
require_relative 'pet_shelter'
require_relative 'pet'

# Configuration
host = 'a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com'
port = 8883
certificate_path = '../certs/certificate.pem.crt'
private_key_path = '../certs/private.pem.key'
root_ca_path = '../certs/root-CA.pem'
topic = 'workshop/pet'
service_name = 'pet'

# MQTT client
client = AwsIotDevice::MqttShadowClient::MqttManager.new(host: host, port: port, ssl: true)
client.config_ssl_context(root_ca_path, private_key_path, certificate_path)
client.connect

def wrap_payload(payload)
  payload.to_h.merge(service_name: 'pet').to_json
end

client.subscribe('workshop/player/pet_adoption_requested', 0, proc do |message|
  pet_name = JSON.parse(message.payload)['pet_name']
  pet = PetShelter.adopt(pet_name)
  client.publish('workshop/pet/pet_adopted', wrap_payload(pet))
end)

client.subscribe('workshop/time/tick', 0, proc do |_message|
  PetShelter.all.each do |pet|
    pet.get_tired
    client.publish('workshop/pet/pet_updated', wrap_payload(pet))
  end
end)

client.subscribe('workshop/environment/sun_rose', 0, proc do |_message|
  PetShelter.all.each do |pet|
    pet.wake_up
    client.publish('workshop/pet/pet_updated', wrap_payload(pet))
  end
end)

client.subscribe('workshop/environment/sun_set', 0, proc do |_message|
  PetShelter.all.each do |pet|
    pet.sleep
    client.publish('workshop/pet/pet_updated', wrap_payload(pet))
  end
end)

client.subscribe('workshop/player/pet_fed', 0, proc do |_message|
  pet_name = JSON.parse(message.payload)['pet_name']
  pet = PetShelter.get(pet_name)
  pet.fed
  client.publish('workshop/pet/pet_updated', wrap_payload(pet))
end)

client.subscribe('workshop/player/pet_entertained', 0, proc do |_message|
  pet_name = JSON.parse(message.payload)['pet_name']
  pet = PetShelter.get(pet_name)
  pet.entertained
  client.publish('workshop/pet/pet_updated', wrap_payload(pet))
end)


client.subscribe('workshop/pet/pet_updated', 0, proc do |_message|
  pet_name = JSON.parse(message.payload)['pet_name']
  pet = PetShelter.get(pet_name)
  if !pet.alive?
    client.publish('workshop/pet/pet_died', wrap_payload({pet_name: pet.name}))
    PetShelter.bury(pet_name)
  end
end)

client.subscribe('workshop/time/reset', 0, proc do |_message|
  PetShelter.clear
end)

# Loop forever publishing a new message to topic every three seconds
loop do
  # client.publish(topic, "Hello from pet service where time is now #{Time.now.to_i}")
  client.publish('workshop/player/pet_adoption_requested', { pet_name: 'Bob' }.to_json)
  sleep 10
end

# Use 'client.disconnect' if you don't want to loop forever
