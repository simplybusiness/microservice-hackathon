class EventBus
  def initialize
    @client = setup_event_client
  end

  def subscribe(topic_pattern, _, callback)
    @client.subscribe(topic_pattern, 0, callback)
  end

  def publish(topic, payload='')
    @client.publish(topic, payload)
  end

  def setup_event_client
    host = "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com"
    port = 8883
    certificate_path = "../certs/certificate.pem.crt"
    private_key_path = "../certs/private.pem.key"
    root_ca_path = "../certs/root-CA.pem"
    client = AwsIotDevice::MqttShadowClient::MqttManager.new(host: host, port: port, ssl: true)
    client.config_ssl_context(root_ca_path, private_key_path, certificate_path)
    client.connect
    client
  end

end
