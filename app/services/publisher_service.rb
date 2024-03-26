# frozen_string_literal: true

class PublisherService
  DEFAULT_OPTIONS = { durable: true, auto_delete: false }

  def self.publish(queue_name:, payload:)
    queue = channel.queue(queue_name, DEFAULT_OPTIONS)
    queue.publish(payload, routing_key: queue.name)
  end

  def self.channel
    BunnyClient.instance.channel
  end
end
