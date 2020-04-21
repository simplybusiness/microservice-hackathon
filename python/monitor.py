#!/usr/bin/python3 -u
import time
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient

# For certificate based connection
myMQTTClient = AWSIoTMQTTClient("python_monitor")

# Configurations
# For TLS mutual authentication
keyPath = "../certs/private.pem.key"
certPath = "../certs/certificate.pem.crt"
caPath = "../certs/root-CA.pem"
myMQTTClient.configureEndpoint("a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com", 8883)
myMQTTClient.configureCredentials(caPath, keyPath, certPath)

def message_logger(client, userdata, msg):
    print("on topic: " + msg.topic + ", message: " + msg.payload.decode("ascii"))

myMQTTClient.connect()
myMQTTClient.subscribe("workshop/#", 1, message_logger)

while True:
    None
    
print("unsubscribing...")
myMQTTClient.unsubscribe("workshop/+")
myMQTTClient.disconnect()
