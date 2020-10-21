require 'json'
require 'securerandom'
require 'benchmark'

module ApplicationLoader
  extend self

  def load_app!
    require_app
    init_lib
    require_initializers
    load_debugger
  end

  private

  def require_app
    require_file 'config/application'
  end

  def init_lib
    require_dir 'lib'
  end

  def require_initializers
    require_dir 'config/initializers'
  end

  def load_debugger
    return unless %w[test development].include?(ENV['RACK_ENV'])

    require 'byebug'
  end

  def require_file(path)
    require File.join(root, path)
  end

  def require_dir(path)
    path = File.join(root, path)
    Dir["#{path}/**/*.rb"].each {|file| require file}
  end

  def root
    File.expand_path('..', __dir__)
  end
end
