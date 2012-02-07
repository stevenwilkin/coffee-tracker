require 'logger'

if "production".eql?(ENV['RACK_ENV'])
  $logger = ::Logger.new(STDOUT)
else
  $logger = ::Logger.new("#{File.dirname(__FILE__)}/../log/#{ENV['RACK_ENV']}.log")
end

$logger.level = Logger::DEBUG
