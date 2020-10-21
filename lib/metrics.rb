module Metrics
  extend self

  def configure_client
    registry = Prometheus::Client.registry

    yield registry

    registry.metrics.each do |m|
      define_method(m.name) {m}
    end
  end

  def configure_histogram
    registry = Prometheus::Client.registry

    yield registry

    registry.metrics.each do |m|
      define_method(m.name) {m}
    end
  end
end
