// An example MQTT service that publishes and subscribes
// Uses the AWS IoT messaging service
// Libraries
var aws_iot = require('aws-iot-device-sdk')

// Configuration
const service_name = 'test_monitor'
const aws_iot_config = {
  keyPath: "../certs/private.pem.key",
  certPath: "../certs/certificate.pem.crt",
  caPath: "../certs/root-CA.pem",
  clientId: service_name,
  host: "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com",
  debug: false
}
const client = aws_iot.device(aws_iot_config)

// Main
client.on('connect', () => {
  // The '#' wildcard matches all topics below this one
  client.subscribe('workshop/#', function (err) {
    if (!err) {
      console.log('Monitoring topic workshop/#')
      console.log('Press Control-C to quit.')
    }
  })
})

client.on('message', (topic, message) => {
  console.log(`Message on topic: ${topic} is: ${message.toString()}`)
})
