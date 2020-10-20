module RabbitMq
  extend self

  def connection
    @connection ||= Bunny.new(
      host: ENV['RABBITMQ_HOST'],
      username: ENV['RABBITMQ_USER'],
      password: ENV['RABBITMQ_PASS'],
    ).start
  end

  def consumer_channel
    Thread.current[:rabbitmq_consumer_channel] ||= connection.create_channel( nil, 10 )
  end
end
