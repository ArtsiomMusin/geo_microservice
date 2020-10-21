channel = RabbitMq.consumer_channel
queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  coordinates = nil
  Metrics.geocoding_duration.observe(Benchmark.realtime { coordinates = Geocoder.geocode(payload['city'] || '') }, labels: { service: 'geocoder' })

  p payload
  p coordinates

  if coordinates
    Metrics.geocoding_requests_total.increment(labels: {result: 'success'})
    client = AdsService::Client.new
    result = client.update_coordinates(payload['id'], coordinates)
    channel.ack(delivery_info.delivery_tag) if result.success?
  else
    Metrics.geocoding_requests_total.increment(labels: {result: 'failure'})
  end
end
