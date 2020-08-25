module RabbitMq
  extend self

  def connection
    @connection ||= Bunny.new.start
  end

  def consumer_channel
    Thread.current[:rabbitmq_consumer_channel] ||= connection.create_channel( nil, 10 )
  end
end
