channel = RabbitMq.consumer_channel
queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  coordinates = Geocoder.geocode(payload['city'])

  p payload

  if coordinates
    client = AdsService::Client.new
    result = client.update_coordinates(payload['id'], coordinates)
    channel.ack(delivery_info.delivery_tag) if result.success?
  end
end
