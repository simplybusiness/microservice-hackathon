#!/usr/bin/python3 -u
import time
import json
import doctest
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient

world_exists = False
current_hour = 0

def connect(client_name):
    # For certificate based connection
    myMQTTClient = AWSIoTMQTTClient(client_name)

    # Configurations
    # For TLS mutual authentication
    keyPath = "../certs/private.pem.key"
    certPath = "../certs/certificate.pem.crt"
    caPath = "../certs/root-CA.pem"
    myMQTTClient.configureEndpoint(
        "a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com", 8883
    )
    myMQTTClient.configureCredentials(caPath, keyPath, certPath)
    myMQTTClient.connect()
    return myMQTTClient

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
    '{"hours_elapsed": 3}'
    """
    message = json.dumps({"hours_elapsed": current_hour})
    return message

def subscribe(sub_client, topic):
    sub_client.subscribe(topic, 1, message_handler)

def publish_timer(client):
    global current_hour
    client.publish("workshop/time/tick", get_message(current_hour), 0)
    current_hour = increase_hour(current_hour)

def message_handler(client, userdata, msg):
    #"""Check state and handle messages as needed
    #>>> world_exists = False; message_handler('dummy','dummy',{"topic":"workshop/environment/big_bang"}); world_exists
    #True
    #"""
    global world_exists
    global current_hour
    if msg.topic == "workshop/environment/big_bang" and not world_exists:
        print("BIG BANG!!!!")
        world_exists = True
    elif msg.topic == "workshop/environment/big_bang" and world_exists:
        print("ANOTHER BIG BANG!!!!")
        current_hour = 0
    elif msg.topic == "workshop/time/reset":
        print("TIME RESET!!!!")
        current_hour = 0

def unsubscribe(sub_client, topic):
    client.unsubscribe(topic)

if __name__ == "__main__":
    doctest.testmod()
    sub_client = connect("python_sub_client")
    subscribe(sub_client, "workshop/#")
    while True:
        time.sleep(10)
        if world_exists:
            publish_timer(sub_client)
