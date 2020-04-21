require_relative 'world'
require 'minitest/autorun'

def create_event(topic:, payload:)
  @client.publish(topic, payload)
end

def event_published(topic:)
  @events.any? { |event| event.topic == topic }
end

describe World do
  def setup
    super
    host = "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com"
    port = 8883
    certificate_path = "../certs/certificate.pem.crt"
    private_key_path = "../certs/private.pem.key"
    root_ca_path = "../certs/root-CA.pem"
    @events = []
    @client = AwsIotDevice::MqttShadowClient::MqttManager.new(host: host, port: port, ssl: true)
    @client.config_ssl_context(root_ca_path, private_key_path, certificate_path)
    @client.connect
    callback = Proc.new do |message|
      @events.append(message)
    end
    @client.subscribe("workshop/#", 0, callback)
  end

  def wait_for_events
    sleep 1
  end

  describe "when time starts" do
    it "starts the world" do
      World.create
      wait_for_events
      assert event_published(topic: "workshop/environment/big_bang"), "Cannot find big bang event"
    end
  end
end
