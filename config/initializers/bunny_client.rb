# frozen_string_literal: true

require 'bunny'

class BunnyClient
  include Singleton
  attr_reader :active_connection, :active_channel

  def initialize
    establish_connection
  end

  def establish_connection
    @active_connection = Bunny.new(ENV['CLOUDAMQP_URL'])
    active_connection.start
    @active_channel = active_connection.create_channel

    @active_connection
  end

  def connection
    return active_connection if connected?
    establish_connection

    active_connection
  end

  def channel
    return active_channel if connected? && active_channel&.open?
    establish_connection

    active_channel
  end

  def connected?
    active_connection&.connected?
  end
end
