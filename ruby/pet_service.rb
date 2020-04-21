# Imports
require 'aws_iot_device'

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

# Helpers
callback = Proc.new do |message|
  puts "On topic: #{message.topic}, message: #{message.payload}"
end

player_callback = Proc.new do |message|
  case message.payload['message type']
  when 'pet_adoption_requested'
    # do something
  when 'pet_entertained'
    # do something
  when 'pet_fed'
    # do something
  end
end

# Main
#
# Register a callback message logger on our topic
client.subscribe("workshop/+", 0, callback)

client.subscribe("workshop/player", 0, player_callback)


# Loop forever publishing a new message to topic every three seconds
loop do
  client.publish(topic, "Hello from pet service where time is now #{Time.now.to_i}")
  sleep 3
end

# Use 'client.disconnect' if you don't want to loop forever

