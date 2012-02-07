require 'sinatra'

require_relative 'conf/logger'
require_relative 'conf/redis'

class CoffeeTracker < Sinatra::Base

  post '/' do
  end

end
