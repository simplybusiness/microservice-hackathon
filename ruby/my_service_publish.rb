#require 'minitest/autorun'
require 'aws_iot_device'

def event_published(topic:)
  (@events || []).any? { |event| event.topic == topic }
end

class World
  def self.create
    host = "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com"
    port = 8883
    certificate_path = "../certs/certificate.pem.crt"
    private_key_path = "../certs/private.pem.key"
    root_ca_path = "../certs/root-CA.pem"
    client = AwsIotDevice::MqttShadowClient::MqttManager.new(host: host, port: port, ssl: true)
    client.config_ssl_context(root_ca_path, private_key_path, certificate_path)
    client.connect
    loop do
    client.publish('workshop/big_bang', 'hello from big bang')
    sleep 3
    end
  end
end

World.create

