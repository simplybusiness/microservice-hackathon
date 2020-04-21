# Imports
require 'aws_iot_device'

# Configuration
host = "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com"
port = 8883
certificate_path = "../certs/certificate.pem.crt"
private_key_path = "../certs/private.pem.key"
root_ca_path = "../certs/root-CA.pem"
service_name = 'pet-monitor'

# MQTT client
client = AwsIotDevice::MqttShadowClient::MqttManager.new(host: host, port: port, ssl: true)
client.config_ssl_context(root_ca_path, private_key_path, certificate_path)
client.connect

# Helpers
callback = Proc.new do |message|
  puts "On topic: #{message.topic}, message: #{message.payload}"
end

# Main
#
# Register a callback message logger on our topic
client.subscribe("workshop/#", 0, callback)

# Loop forever publishing a new message to topic every three seconds
loop do
  client.publish("workshop/player/pet_adoption_requested", { pet_name: "Bob" }.to_json)
  sleep 5
end

# Use 'client.disconnect' if you don't want to loop forever

