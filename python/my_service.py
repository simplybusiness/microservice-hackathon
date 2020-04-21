#!/usr/bin/python3 -u
import time
import json
import doctest
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient


def increase_hour(current_hour):
    """Current hour sent via message must be a positive integer greater than 0
    >>> increase_hour(3)
    4
    >>> increase_hour(3) > 0
    True
    >>> isinstance(increase_hour(3), int)
    True
    """
    return current_hour + 1

def get_message(current_hour):
    """Receive a Python dict and return a valid JSON string with key hours_elapsed
    >>> get_message(3)
    '{"message_type": "tick", "message": {"hours_elapsed": 3}}'
    """

    message = json.dumps({"message_type" : "tick", "message" : {"hours_elapsed": current_hour}})
    return message

def connect_and_publish():
    current_hour = 0

    # For certificate based connection
    myMQTTClient = AWSIoTMQTTClient("python_kittens")

    # Configurations
    # For TLS mutual authentication
    keyPath = "../certs/private.pem.key"
    certPath = "../certs/certificate.pem.crt"
    caPath = "../certs/root-CA.pem"
    myMQTTClient.configureEndpoint(
        "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com", 8883
    )
    myMQTTClient.configureCredentials(caPath, keyPath, certPath)

    def message_logger(client, userdata, msg):
        print("on topic: " + msg.topic + ", message: " + msg.payload.decode("ascii"))

    myMQTTClient.connect()
    myMQTTClient.subscribe("workshop/+", 1, message_logger)

    while True:
        message = {"hours_elapsed": current_hour}
        myMQTTClient.publish("workshop/time", get_message(current_hour), 0)
        current_hour = increase_hour(current_hour)
        time.sleep(10)

    myMQTTClient.unsubscribe("workshop/+")
    myMQTTClient.disconnect()


if __name__ == "__main__":
    doctest.testmod()
    connect_and_publish()
