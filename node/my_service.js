// An example MQTT service that publishes and subscribes
// Uses the AWS IoT messaging service
// Libraries
var aws_iot = require('aws-iot-device-sdk')

// Constants
const EVERY_THREE_SECONDS = 3000

// Configuration
const service_name = 'node_kittens'
const aws_iot_config = {
  keyPath: "../certs/private.pem.key",
  certPath: "../certs/certificate.pem.crt",
  caPath: "../certs/root-CA.pem",
  clientId: service_name,
  host: "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com",
  debug: false
}
const client = aws_iot.device(aws_iot_config)

// Helpers
const get_time = () => parseInt((new Date().getTime() / 1000).toFixed(0))

// Main
client.on('connect', () => {
  // The '#' wildcard matches all topics below this one
  client.subscribe('workshop/#', function (err) {
    if (!err) {
      client.publish('workshop/kittens', `Service: ${service_name} has connected!`)
      console.log('Press Control-C to quit.')
    }
  })
  setInterval(() => {
    client.publish('workshop/kittens',
                   `At the third stroke, the time will be: ${get_time()}`)
  }, EVERY_THREE_SECONDS)
})

client.on('message', (topic, message) => {
  // message is of type Buffer, so we need to use .toString
  console.log(`Message on topic: ${topic} is: ${message.toString()}`)
  // client.end() // comment this to loop forever
})
