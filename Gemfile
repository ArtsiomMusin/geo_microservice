# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) {|repo_name| 'https://github.com/#{repo_name}' }

gem 'rake'
gem 'rack'
gem 'puma'
gem 'bunny', '>= 2.14.1'
gem 'dry-initializer', '~> 3.0.3'
gem 'faraday'
gem 'faraday_middleware'
gem 'prometheus-client'

group :development do
  gem 'byebug'
end

group :test do
  gem 'rspec-roda'
end
