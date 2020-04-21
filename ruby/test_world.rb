require_relative 'world'
require_relative 'event_bus'
require 'minitest/autorun'

describe World do
  describe 'when time starts' do
    it 'starts the world' do
      World.create(env: "test")
      wait_for_events
      assert event_published(topic: 'workshop-test/environment/big_bang'), 'Cannot find big bang event'
    end
  end

  describe 'given that the sun rises at 8, at 8 oclock on the first day' do
    it 'triggers the sun to rise' do
      thread = Thread.new { World.run(env: "test") }
      wait_for_events
      EventBus.new.publish('workshop-test/time/tick', {"hours_elapsed": 8}.to_json)
      wait_for_events
      assert event_published(topic: 'workshop-test/environment/sun_rose'), "Sun did not rise"
      Thread.kill(thread)
    end
  end

  describe 'given that the sun rises at 8, at 7 oclock on the first day' do
    it 'the sun has not risen' do
      thread = Thread.new { World.run(env: "test") }
      wait_for_events
      EventBus.new.publish('workshop-test/time/tick', {"hours_elapsed": 7}.to_json)
      wait_for_events
      refute event_published(topic: 'workshop-test/environment/sun_rose'), "Sun should not have risen"
      Thread.kill(thread)
    end
  end

  def setup
    super
    @events = []
    EventBus.new.subscribe('workshop-test/#', 0, ->(event) { @events.append(event) })
  end

  private

  def event_published(topic:)
    @events.any? { |event| event.topic == topic }
  end

  def wait_for_events
    sleep 1
  end
end
