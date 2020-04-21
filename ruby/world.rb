require 'aws_iot_device'
require_relative 'event_bus'

class World
  def self.run
    create
    loop do
      # loop here
    end
  end

  def self.create
    EventBus.new.publish('workshop/environment/big_bang', '')
  end
end
