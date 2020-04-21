require_relative 'world'
require_relative 'event_bus'
require 'minitest/autorun'

describe World do
  describe 'when time starts' do
    it 'starts the world' do
      World.create
      wait_for_events
      assert event_published(topic: 'workshop/environment/big_bang'), 'Cannot find big bang event'
    end
  end

  def setup
    super
    @events = []
    EventBus.new.subscribe('workshop/#', 0, ->(event) { @events.append(event) })
  end

  private

  def event_published(topic:)
    @events.any? { |event| event.topic == topic }
  end

  def wait_for_events
    sleep 1
  end
end
