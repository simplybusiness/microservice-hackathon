require 'aws_iot_device'
require_relative 'event_bus'

class World
  def self.run(env: "prod")
    create(env: env)
    namespace = env == "prod" ? "workshop" : "workshop-test"
    EventBus.new.subscribe("#{namespace}/time/tick", 0, time_moved_on(env: env))
    loop do

      sleep 5
    end
  end

  def self.create(env: "prod")
    namespace = env == "prod" ? "workshop" : "workshop-test"
    EventBus.new.publish("#{namespace}/environment/big_bang", {})
  end

  def self.time_moved_on(env:)
    lambda do |message|
      namespace = env == "prod" ? "workshop" : "workshop-test"
      if JSON.parse(message.payload)["hours_elapsed"] == 8
        EventBus.new.publish("#{namespace}/environment/sun_rose", {})
      end
    end
  end

end
