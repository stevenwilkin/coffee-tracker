require 'sinatra'

require_relative 'conf/logger'
require_relative 'conf/redis'

class CoffeeTracker < Sinatra::Base

  post '/api' do
    api_key = env['HTTP_X_API_KEY']
    unless api_key
      halt 401, {'Content-Type' => 'text/plain'}, 'Missing API Key'
    end
    unless $redis.sismember 'api_keys', api_key
      halt 403, {'Content-Type' => 'text/plain'}, 'Invalid API Key'
    end

    $redis.hincrby 'coffee', Time.now.strftime("%Y%m%d"), 1
    200
  end
end
