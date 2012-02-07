ENV['RACK_ENV'] ||= 'test'

require 'simplecov'
require 'test/unit'
require 'rack/test'

require_relative '../courier'

module TestHelpers
  include Rack::Test::Methods

  def app
    # use a module variable so the app is only ever initialised once
    # NOTE: possible source of nastiness doing this? makes tests run faster...
    unless defined? @@app
      config = File.read(File.join(File.dirname(__FILE__), '..', 'config.ru'))
      @@app = eval("Rack::Builder.new {(#{config})}")
    end
    @@app
  end
end
