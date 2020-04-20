# Building Event-Driven Services Workshop

This repository includes the boilerplate code for the Simply Business' `Building Event-Driven Services Worshop` using a number of languages. Please feel free to help add implementation in more languages. PRs would be gratefully accepted.

## Background

This code is forked from @sleepyfox's original Github [repo](https://github.com/sleepyfox/microservice-hackathon). This originally used a public test message broker. We have since set up a managed message broker in AWS, `a267zn9knxsui0-ats.iot.eu-west-1.amazonaws.com`, which was provisioned in the `sb-dojo` AWS account.

## Protocol

The code samples use MQTT (Massage Queuing Telemetry Transport) which is an [OASIS](https://en.wikipedia.org/wiki/Organization_for_the_Advancement_of_Structured_Information_Standards) and [ISO standard](https://en.wikipedia.org/wiki/International_Organization_for_Standardization) (ISO/IEC 20922). MQTT is lightweight pub/sub network protocol that transports messages between devices. It has been adopted as the *de facto* protocol for Internet of Things (IoT) devices to exchange data by all three major public cloud providers, Google Cloud, Microsoft Azure and AWS.

Apart from the simplicity of the protocol, another reason for choosing an MQTT server for this training is its [low cost](https://aws.amazon.com/iot-core/pricing/). It costs `$0.042` per device for a year of connectivity and `$1.00` per million messages.

This repository includes enough information and necessary credentials to connect to the MQTT server, to publish events and to subscribe to all topics on the server. The code samples in all included languages are designed to work as they are to lower the cognitive load for the workshop's attendees.

**Why are the secrets not encrypted?**

This is a reasonable question that should be asked by any SB engineers coming across this repo. In providing the boilerplate code for a one-day workshop, we don't want our attendees to waste time on secret management, which tends to go off-script. The following factors help mitigate this apparent lack of security:

+ This repository is private to Simply Business.
+ The secrets can only be used to connect to an AWS MQTT server in the `sb-dojo` account, which is only used for training purposes.
+ As mentioned before, AWS MQTT is a very low-cost service.

# LICENSE
See LICENSE file - MIT.
