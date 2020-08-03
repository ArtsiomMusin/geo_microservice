require 'spec_helper'

ENV['RACK_ENV'] ||= 'test'

require_relative '../config/environment'

Dir[File.expand_path('./support/**/*.rb', __dir__)].sort.each {|f| require f}

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :route
  config.include FixtureHelpers
end
