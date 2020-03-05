const mqtt = require('mqtt')
const newInfection = require('./new_infection');
const Redis = require("ioredis");
const redis = new Redis(); // uses defaults unless given configuration object


let infectionRate = 0;

const MQTT_HOST = process.env.MQTT_HOST || 'mqtt.fluux.io'
const service_name = 'infection'
var client  = mqtt.connect(`mqtt://${MQTT_HOST}`)

client.on('connect', function () {
  // The '#' wildcard matches all topics below this one
  client.subscribe('uservicehack/+', function (err) {
    // if (!err) {
    //   client.publish('uservicehack/infection', `Service: ${service_name} has connected!`)
    // }
  })
})
let payload = {};
client.on('message', function (topic, message) {
  // message is of type Buffer, so we need to use .toString
  console.log(`Message on topic: ${topic} is: ${message.toString()}`)
  switch(topic){
    case 'uservicehack/borough':
      payload = JSON.parse(message.toString());

      client.publish(
        'uservicehack/infection',
        JSON.stringify({'borough': payload.name, 'new_infections': newInfection(infectionRate, payload)})
      );

      break;

    case 'uservicehack/mutation':
      payload = JSON.parse(message.toString());
      infectionRate = payload.infection_rate/100;
      break;
  }

  // client.end() // Remove this to loop forever
});

