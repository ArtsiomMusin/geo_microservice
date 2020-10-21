require 'prometheus/middleware/exporter'
require 'prometheus/client'

Metrics.configure_client do |registry|
  registry.counter(
    :geocoding_requests_total,
    docstring: 'Total number of geocoding requests',
    labels: %i[result]
  )
end

Metrics.configure_histogram do |registry|
  registry.histogram(
    :geocoding_duration,
    docstring: "Geocoding duration",
    labels: %i[service]
  )
end
