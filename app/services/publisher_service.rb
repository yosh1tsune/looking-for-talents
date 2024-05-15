# frozen_string_literal: true

class PublisherService
  def self.publish(topic:, routing_key:, payload:)
    exchange = channel.topic(topic)
    channel.queue(routing_key).bind(exchange, routing_key: routing_key)
    exchange.publish(payload, routing_key: routing_key)
  end

  def self.channel
    BunnyClient.instance.channel
  end
end
