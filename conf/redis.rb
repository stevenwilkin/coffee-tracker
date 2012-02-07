require 'redis'

host = 'localhost'
port = 6379
db = 0

case ENV['RACK_ENV']
  when 'development'
    $logger.debug("---> development Redis")    
    $redis = Redis.new(:host => host, :port => port, :db => db)
  when 'test'
    db = 1
    $logger.debug("---> test Redis")
    $redis = Redis.new(:host => host, :port => port, :db => db)
  when 'production'
   # RedisToGo on Heroku
   #
   if ENV['REDISTOGO_URL']
     $logger.debug("---> production Redis at " + ENV['REDISTOGO_URL'])
     uri = URI.parse(ENV['REDISTOGO_URL'])
     # Timeout is in seconds
     $redis = Redis.new(:host => uri.host, :port => uri.port, :db => uri.path, :password => uri.password, :user => uri.user, :timeout => 120)
   else     
     $logger.debug("---> production Redis  " + + host + ":" + port.to_s + "/" +db)
     $redis = Redis.new(:host => host, :port => port, :db => db)
   end
end

