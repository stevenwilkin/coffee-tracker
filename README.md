# coffee-tracker

A simple web service to track the number of cups of coffee I consume each day.


## Configuring Redis

Redis is the sole datastore for this app.

If deploying to Heroku, the free [RedisToGo](https://redistogo.com) addon  can be used thus:

	$ heroku addons:add redistogo:nano

For other situations you may want to modify `conf/redis.rb` accordingly.


## API keys

Write access to the service is controlled via API key. The key is specified in
the `X-API-Key` header when POSTing to the service. A request with missing or
invalid key will receive a 4xx response code.


### Specifying an API key

Add the desired key to the `api_keys` set:

	$ redis-cli
	redis> SADD api_keys YOUR_API_KEY
	(integer) 1


### Checking API keys

	redis> SMEMBERS api_keys
	1) "YOUR_API_KEY"


## Running

Assuming Redis is installed and running locally:

	$ git clone https://github.com/stevenwilkin/coffee-tracker.git .
	$ bundle install
	$ bundle exec rackup

Web interface is then available at [http://0.0.0.0:9292](http://0.0.0.0:9292).

## Tests

The test suite uses Minitest which is now part of the Ruby 1.9.x standard library and can be kicked off with Rake:

	$ bundle exec rake

## API

### GET /api

Retrieves the current count:

	$ curl http://0.0.0.0:9292/api
	5


### POST /api

Updates the count, returning the updated count in the response body as text/plain:

	$ curl -X POST -d '' -H X-API-Key:YOUR_API_KEY http://0.0.0.0:9292/api
	6